# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create a default admin user
AdminUser.find_or_create_by_email 'manager@luleka.com', {
  :password              => 'buenosaires11:rosanegra',
  :password_confirmation => 'buenosaires11:rosanegra'
}