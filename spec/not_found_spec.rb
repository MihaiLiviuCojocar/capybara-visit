require './app/server'
require 'capybara/rspec'

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara::DSL
end

class Capybara::Session
  alias_method :old_visit, :visit

  def visit(url, status_code = (200 .. 299) )
    old_visit(url)
    raise Capybara::FileNotFound.new("Unexpected status code #{driver.status_code}" )  unless status_code.include? driver.status_code
  end
end

describe "404 links" do
  context "When accessing a page that doesn't exist" do
    it 'should fail the test' do
      expect{visit '/404'}.to raise_error(Capybara::FileNotFound)
    end
  end
end
