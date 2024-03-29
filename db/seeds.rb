# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create a default admin user
require File.expand_path(File.dirname(__FILE__) + '/import')

@import.each do |hash|
  Registration.find_or_create_by_email hash[:email] do |r|
    r.first_name = hash[:first_name]
    r.last_name = hash[:last_name]
    r.country_code = hash[:country_code]
    r.time_zone = hash[:time_zone]
    r.locale = hash[:language_code]
  end
end

AdminUser.find_or_create_by_email 'manager@luleka.com', {
  :password              => 'buenosaires11:rosanegra',
  :password_confirmation => 'buenosaires11:rosanegra'
}

Social::Event::Code.create_records!

