class AddNameAndTimeZoneToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :first_name, :string
    add_column :registrations, :last_name, :string
    add_column :registrations, :time_zone, :string
  end
end
