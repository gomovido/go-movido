Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(args: %w[no-sandbox headless disable-gpu window-size=1400,900])
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.save_path = Rails.root.join('tmp/capybara')
Capybara.javascript_driver = :headless_chrome
Capybara.default_driver = :rack_test
Capybara.default_max_wait_time = 2

RSpec.configure do |config|

  config.before(:each) do |example|
    Capybara.current_driver = :headless_chrome if example.metadata[:headless_chrome]
    Capybara.current_driver = :selenium_chrome if example.metadata[:selenium_chrome]
  end
  config.after(:each) do
    Capybara.use_default_driver
  end
end
