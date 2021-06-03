source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1', '>= 6.1.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0", require: ["redis", "redis/connection/hiredis"]
gem "hiredis"
gem 'iso_country_codes'
gem 'globalize'
gem "activerecord-nulldb-adapter"
gem 'rubocop', require: false
gem 'slack-notifier'
gem 'forest_liana'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'devise', github: 'heartcombo/devise'
gem 'autoprefixer-rails'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
gem 'postmark-rails'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'
gem "omniauth", "~> 1.9.1"
gem 'travis'

group :development, :test do
  gem 'pry-byebug'
  gem 'shoulda-matchers'
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'bullet'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails', '~> 4.0.2'
  gem "factory_bot_rails"
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "letter_opener"
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  # Easy installation and use of web drivers to run system tests with browsers
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem "stimulus_reflex", github: "hopsoft/stimulus_reflex", branch: "master"

gem "phony_rails", "~> 0.14.13"

gem "intercom-rails", "~> 0.4.2"

gem 'rails-i18n'

gem "iban-tools", "~> 1.1"

gem "stripe", "~> 5.28"

gem "browser"

gem 'rubocop-performance', require: false

gem "httparty", "~> 0.18.1"

gem "appsignal", "~> 2.11"

gem "rubocop-rails", "~> 2.9"

gem "rubocop-rspec", "~> 2.2"

gem "stimulus_reflex_testing", "~> 0.3.0"
