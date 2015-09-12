#!/usr/bin/env ruby

require 'oauth'
require 'net/http'
require 'mechanize'
require 'json'

class KhanAcademy

  API_PATH = 'https://www.khanacademy.org/api/'
  USER_PATH = "#{API_PATH}v1/user"
  OAUTH_PATH = "#{API_PATH}auth2/"
  REQUEST_TOKEN_PATH = "#{OAUTH_PATH}request_token"
  AUTHORIZE_PATH = "#{OAUTH_PATH}authorize"
  ACCESS_TOKEN_PATH = "#{OAUTH_PATH}access_token"

  public
  def initialize args = {}
    raise 'Consumer key not provided.' unless args[:key]
    raise 'Consumer secret not provided.' unless args[:secret]
    raise 'Username not provided.' unless args[:username]
    raise 'Password not provided.' unless args[:password]

    agent = args[:agent] || Mechanize.new

    request_token = OAuth::Consumer.new(args[:key],
                                        args[:secret],
                                        request_token_path: REQUEST_TOKEN_PATH,
                                        authorize_path: AUTHORIZE_PATH,
                                        access_token_path: ACCESS_TOKEN_PATH)
                                   .get_request_token
    agent.post AUTHORIZE_PATH, oauth_token: request_token.token,
                               identifier: args[:username],
                               password: args[:password]

    ap JSON.parse(request_token.get_access_token.get(USER_PATH).body)['points']

  end

  def points
    # ap
  end

end
