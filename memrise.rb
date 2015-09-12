require 'mechanize'

class Memrise

  LOGIN_URL = 'https://www.memrise.com/login/'

  public
  def initialize args = {}
    raise 'Username not provided.' unless args[:username]
    raise 'Password not provided.' unless args[:password]

    @agent = args[:agent] || Mechanize.new

    @username = args[:username]
    @password = args[:password]

    login
  end

  def points
    raise 'Dashboard (Home) not loaded.' unless @dashboard
    @dashboard
        .search('.content-stats .right .number').first.content
        .gsub(',', '').to_i
  end

  private
  def login
    login_page = @agent.get LOGIN_URL
    login_form = login_page.forms.first

    login_form.username = @username
    login_form.password = @password

    dashboard = @agent.submit login_form
    raise 'Login failed.' if dashboard.search('body.dashboard').empty?
    @dashboard = dashboard
  end

end
