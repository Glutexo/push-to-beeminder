#!/usr/bin/env ruby

require 'awesome_print'
require 'erb'
require 'net/http'

class Beeminder

  DATAPOINT_URL = "https://www.beeminder.com/api/v1/users/<%= @username %>/goals/<%= @goal %>/datapoints.json?auth_token=<%= @auth_token %>"

  def initialize args = {}
    raise 'Authorization token not provided.' unless args[:auth_token]
    raise 'Goal URL name not provided.' unless args[:goal]
    raise 'Username not provided.' unless args[:username]

    @auth_token = args[:auth_token]
    @goal = args[:goal]
    @username = args[:username]
  end

  def datapoint_url
    ERB.new(DATAPOINT_URL).result binding
  end

  def create_datapoint value
    Net::HTTP::post_form URI(datapoint_url), value: value
  end

end
