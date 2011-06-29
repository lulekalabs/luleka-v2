source 'http://rubygems.org'

gem 'rails', '3.0.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

gem 'mysql2', "~> 0.2.0"
gem 'jquery-rails'

group :test do
  gem 'simplecov', '>= 0.4.0', :require => false
  gem 'minitest'
  gem 'ruby-debug19' unless RUBY_VERSION < "1.9"
end

group :development, :test do
  gem 'capistrano', '2.5.21'
  gem 'mocha', '0.9.12'
  gem 'thin', '1.2.11'
  gem 'ruby-debug19' unless RUBY_VERSION < "1.9"
end

gem 'koala', '1.0.0'
gem 'json', '1.5.1'
gem 'devise', '1.3.4'
gem 'friendly_id4', '4.0.0.pre3', :require => "friendly_id"
