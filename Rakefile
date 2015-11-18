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

task :duolingo do
  require './duolingo'

  beeminder.create_datapoint Duolingo.new(username: ENV['DUOLINGO_USERNAME'])
                                     .points
end