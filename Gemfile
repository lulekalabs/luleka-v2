source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'

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

group :test do
  gem 'simplecov', '>= 0.4.0', :require => false
  gem 'rcov', :platform => :ruby_18
  # Make sure we use the minitest gem for consistency
  gem 'minitest'
  gem 'mocha', '0.9.12'
  gem 'thin', '1.2.11'
end

group :development, :test do
  gem 'capistrano', '2.5.21'
  gem 'ruby-debug19', :platform => :mri_19
  gem 'ruby-debug',   :platform => :mri_18
  gem 'ffaker'
end

platform :jruby do
  gem 'jruby-openssl'
  gem 'ffi-ncurses'
  gem 'mysql'
end

platform :mri do
  gem 'mysql2', "~> 0.3.0"
end

gem 'koala', '1.0.0'
gem 'json', '1.5.1'
gem 'devise', '1.3.4'
gem 'friendly_id4', '4.0.0.beta4', :require => "friendly_id"
gem 'hoptoad_notifier'

#--- paper-trail: versioning models with undo/redo functionality
# https://github.com/airblade/paper_trail
# http://railscasts.com/episodes/255-undo-with-paper-trail
#
# E.g. 
#
#   Post < ActiveRecord::Base
#      has_paper_trail
#   end
#   # @post.reify!
#   # post_version_path(@post, "2")
gem 'paper_trail', '~> 2'

#--- Aloha-Editor: Javascript WYSIWYG Editor
# https://github.com/alohaeditor/Aloha-Editor

# ActiveAdmin and friends
gem 'activeadmin', :git => 'git://github.com/gregbell/active_admin.git', :branch => "rails-3-1"
gem "meta_search", '>= 1.1.0.pre'
gem 'fastercsv'
gem 'kaminari'
gem 'nokogiri'

# temporary fix for 3.1.0.rc4 for assets
gem 'sprockets', '= 2.0.0.beta.10'

# state_machine stuff
gem 'state_machine'
gem 'ruby-graphviz', :require => 'graphviz'

