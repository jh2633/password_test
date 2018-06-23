# require './password'
require './app'
require 'capybara'
require 'capybara/rspec'
require 'selenium/WebDriver'

Capybara.app = Sinatra::Application
RSpec.configure do |config|
  config.include Capybara

end
Capybara.server = :puma, {Silent: true}


# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome
