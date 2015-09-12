#!/usr/bin/env ruby

require 'oauth'
require 'net/http'
require 'mechanize'
require 'json'

class TokenFileMissingError < StandardError

end

class KhanAcademy

  API_PATH = 'https://www.khanacademy.org/api/'
  USER_PATH = "#{API_PATH}v1/user"
  OAUTH_PATH = "#{API_PATH}auth2/"
  REQUEST_TOKEN_PATH = "#{OAUTH_PATH}request_token"
  AUTHORIZE_PATH = "#{OAUTH_PATH}authorize"
  ACCESS_TOKEN_PATH = "#{OAUTH_PATH}access_token"

  # @TODO: Replace with a environment hash to support more users.
  TOKEN_FILE_PATH = 'oauth/khan_academy.token'
  SECRET_FILE_PATH = 'oauth/khan_academy.secret'

  public
  def initialize args = {}
    raise 'Username not provided.' unless args[:username]
    raise 'Password not provided.' unless args[:password]

    @username = args[:username]
    @password = args[:password]

    @agent = args[:agent] || agent
    @consumer = args[:consumer] || consumer(args)

    @access_token = access_token
  end

  def points
    JSON.parse(@access_token.get(USER_PATH).body)['points']
  end

  private

  def agent
    Mechanize.new
  end

  def consumer args = {}
    raise 'Consumer key not provided.' unless args[:key]
    raise 'Consumer secret not provided.' unless args[:secret]
    OAuth::Consumer.new args[:key],
                        args[:secret],
                        request_token_path: REQUEST_TOKEN_PATH,
                        authorize_path: AUTHORIZE_PATH,
                        access_token_path: ACCESS_TOKEN_PATH
  end

  def access_token
    begin
      request_token.get_access_token
    rescue OAuth::Unauthorized
      # @TODO: Test detecting request token expiration.
      request_token_from_server.get_access_token
    end
  end

  def request_token
    begin
      request_token_from_files
    rescue TokenFileMissingError
      request_token_from_server
    end
  end

  def request_token_from_files
    raise TokenFileMissingError unless File.exist?(TOKEN_FILE_PATH) and
                                       File.exist?(SECRET_FILE_PATH)
    OAuth::RequestToken.new @consumer,
                            File.read(TOKEN_FILE_PATH),
                            File.read(SECRET_FILE_PATH)
  end

  def request_token_from_server
    new_token = @consumer.get_request_token
    authorize_request_token new_token
    save_request_token new_token
    new_token
  end

  def authorize_request_token request_token
    @agent.post AUTHORIZE_PATH, oauth_token: request_token.token,
                identifier: @username,
                password: @password
  end

  def save_request_token request_token
    File.write TOKEN_FILE_PATH,  request_token.token
    File.write SECRET_FILE_PATH, request_token.secret
  end

end
