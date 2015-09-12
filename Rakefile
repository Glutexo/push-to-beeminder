require './beeminder'
beeminder = Beeminder.new username:   ENV['BEEMINDER_USERNAME'],
                          auth_token: ENV['BEEMINDER_AUTH_TOKEN'],
                          goal:       ENV['BEEMINDER_MEMRISE_GOAL']

task :memrise do
  require './memrise'
  beeminder.create_datapoint Memrise.new(username: ENV['MEMRISE_USERNAME'],
                                         password: ENV['MEMRISE_PASSWORD'])
                                    .points
end

task :khan_academy do
  require './khan_academy'
  beeminder.create_datapoint KhanAcademy.new(key:      ENV['KHAN_ACADEMY_CONSUMER_KEY'],
                                             secret:   ENV['KHAN_ACADEMY_CONSUMER_SECRET'],
                                             username: ENV['KHAN_ACADEMY_USERNAME'],
                                             password: ENV['KHAN_ACADEMY_PASSWORD'])
                                        .points
end
