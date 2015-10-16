source 'https://rubygems.org'

gem 'rake'
gem 'rails', '4.2.2'
gem 'unicorn'
gem 'jquery-rails', '~> 3.1.3'
gem 'coffee-rails'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks'
gem 'newrelic_rpm'
gem 'rollbar', '~> 2.4.0'
gem 'skylight'
gem 'bootstrap-sass'

group :development, :test do
  gem 'byebug'
  gem 'mysql2', '~> 0.3.20'
end

group :development do
  gem 'foreman'
  gem 'spring', '~> 1.3.5'
  gem 'spring-commands-testunit'
end

group :test do
  gem 'mocha', require: false
  gem 'webmock'
  gem 'test_after_commit'
end

group :production do
  gem 'pg'
end

group :deploy do
  gem 'heroku', '~> 3.8.2'
end

gem 'aasm', '~> 4.3.0'
gem 'clearance', '~> 1.10.1'
