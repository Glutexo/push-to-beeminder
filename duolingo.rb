require 'uri'
require 'net/http'
require 'erb'
require 'json'

class Duolingo

  PROFILE_URL = "https://www.duolingo.com/users/<%= @username %>"

  public
  def initialize args = {}
    raise 'Username not provided.' unless args[:username]

    @username = args[:username]
  end

  def points
    JSON.parse(Net::HTTP.get URI(ERB.new(PROFILE_URL).result binding))['languages'].reduce(0) do |sum, language|
      sum += language['points']
    end
  end

end