require './app'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'


Capybara.app = App
RSpec.configure do |config|
  config.include Capybara

end

Capybara.server = :puma, {Silent: true}


# Comment out the following block if you would prefer to use the default Selenium driver
# using the firefox browser
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.register_driver :chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end
Capybara.javascript_driver = :chrome


#uncomment following lines if using webkit for headless testing instead of default
# require 'capybara-webkit'
# Capybara.javascript_driver = :webkit
# Capybara::Webkit.configure do |config|
#   config.allow_url("https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css")
# end
