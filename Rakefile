task default: %w[mind]

task :mind do
  require './beeminder'
  require './memrise'

  Beeminder.new(username:   ENV['BEEMINDER_USERNAME'],
                auth_token: ENV['BEEMINDER_AUTH_TOKEN'],
                goal:       ENV['BEEMINDER_MEMRISE_GOAL'])
           .create_datapoint Memrise.new(username: ENV['MEMRISE_USERNAME'],
                                         password: ENV['MEMRISE_PASSWORD'])
                                    .points
end