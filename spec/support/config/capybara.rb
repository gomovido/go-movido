Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu window-size=1400,900])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.register_driver :selenium_mobile do |app|
  args = %w[no-sandbox disable-gpu window-size=375,812]
  args << "-user-agent='Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148'"
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.register_driver :headless_mobile do |app|
  args = %w[no-sandbox headless disable-gpu window-size=375,812]
  args << "-user-agent='Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148'"
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.save_path = Rails.root.join('tmp/capybara')
Capybara.javascript_driver = :headless_chrome
Capybara.default_driver = :rack_test
Capybara.default_max_wait_time = 30

RSpec.configure do |config|
  config.before(:each) do |example|
    Capybara.current_driver = :headless_chrome if example.metadata[:headless_chrome]
    Capybara.current_driver = :selenium_chrome if example.metadata[:selenium_chrome]
    Capybara.current_driver = :selenium_mobile if example.metadata[:selenium_mobile]
    Capybara.current_driver = :headless_mobile if example.metadata[:headless_mobile]
  end
  config.after(:each) do
    Capybara.use_default_driver
  end
end
