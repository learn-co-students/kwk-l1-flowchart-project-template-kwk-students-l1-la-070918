ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'

task :console do
  puts "Loaded application environment. Type reload! to reload the code."
  def reload!
    load_all 'app/models'
    load_all 'data/seed'
  end

  Pry.start
end