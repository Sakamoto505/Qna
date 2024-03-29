# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.6'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 6.1.7'
gem 'sassc-rails'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

gem 'turbolinks'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

gem 'webpacker', '~> 5.x'

# Use Redis adapter to run Action Cable in production
gem 'redis', '4.5.0'


# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
#

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem 'active_model_serializers', '~> 0.10'
gem 'cocoon'
gem 'devise'
gem 'doorkeeper'
gem 'gon'
gem 'handlebars-source'
gem 'net-http'
gem 'net-imap'
gem 'net-smtp'
gem 'oj'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'
gem 'pg_search'
gem 'pundit'
gem 'rails_db'
gem 'rubocop'
gem 'rubocop-slim', '~> 0.2.2'
gem 'sidekiq', '~> 6.1'
gem 'sinatra', require: false
gem 'slim-rails'
gem 'twitter-bootstrap-rails'
gem 'uri'
gem 'whenever', require: false
gem 'unicorn'

#deploy
gem 'rake', '13.0.6'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'factory_bot_rails'
  gem 'letter_opener'
  gem 'pry'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-unicorn', require: false


  gem 'capistrano-passenger', require: false

end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'launchy'
  gem 'rack-cors'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'webdrivers'
end
