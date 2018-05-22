ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Rack::Test::Methods
  config.include Capybara::DSL

  config.order = 'default'

  config.after(:each) do
    Quiz.class_variable_set(:@@all, [])
  end
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
