require './app/server'
require 'capybara/rspec'

Capybara.app = Sinatra::Application

RSpec.configure do |config|

  config.include Capybara::DSL

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

class Capybara::Session
  alias_method :old_visit, :visit

  def visit(url, status_code = (200 .. 299) )
    old_visit(url)
    raise Capybara::FileNotFound.new("Unexpected status code #{driver.status_code}" )  unless status_code.include? driver.status_code
  end
end
