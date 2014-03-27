require 'spec_helper'

describe "404 links" do
  context "When accessing a page that doesn't exist" do
    it 'should fail the test' do
      expect{visit '/404', 404}.not_to raise_error(Capybara::FileNotFound)
      expect{visit '/404'}.to raise_error(Capybara::FileNotFound)
    end
  end
end
