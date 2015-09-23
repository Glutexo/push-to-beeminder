#!/usr/bin/env ruby

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
    if datapoint_changed value
      Net::HTTP::post_form URI(datapoint_url), value: value
    end
  end

  def datapoint_changed value
    begin
      last_datapoint = JSON.parse(Net::HTTP::get URI(datapoint_url))[0]['value']
      last_datapoint.to_i != value
    rescue Exception => boom
      raise "Datapoint check failed with: #{boom}"
    end
  end

end
