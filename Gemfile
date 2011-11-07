source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem "icalendar"
gem 'jquery-rails'
gem 'devise'
gem "arel", "2.2.1"

gem 'therubyracer'

group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :development do
  gem 'sqlite3'
  gem 'autotest'
  gem 'autotest-growl'
end

group :test do
  gem 'turn', :require => false
end

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem 'factory_girl_rails'
end

group :production do
  gem 'pg'
end
