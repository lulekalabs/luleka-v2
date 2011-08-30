source 'http://rubygems.org'

gem 'rails', '3.1.0.rc8'
gem 'sass-rails'
gem 'coffee-script'
gem 'uglifier'
gem 'therubyracer'
gem 'jquery-rails'

gem 'mysql2'

group :development, :test do
	gem 'thin'
  gem 'capistrano'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'ffaker'
	gem 'nifty-generators'
end

group :test do
	gem 'turn', :require => false
  gem 'mocha'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl_rails'

  # added for cucumber
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'machinist'
  gem 'pickle'
  gem 'database_cleaner'

  # gem 'simplecov', '>= 0.4.0', :require => false
  # gem 'rcov', :platform => :ruby_18
  # gem 'minitest'
  # gem 'thin', '1.2.11'
end

gem 'koala', '1.0.0'
gem 'json', '1.5.1'
gem 'devise', '1.4.3'
gem 'friendly_id4', '4.0.0.beta4', :require => "friendly_id"
gem 'hoptoad_notifier'

gem 'state_machine'
gem 'ruby-graphviz', :require => 'graphviz'

gem 'geocoder'

#--- ActiveAdmin and friends
gem 'meta_search', '>= 1.1.0.pre' # Avoids activeadmin to hang during bundle install
gem 'activeadmin', :git => 'git://github.com/gregbell/active_admin.git'
gem 'fastercsv'
gem 'kaminari'
gem 'nokogiri'

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