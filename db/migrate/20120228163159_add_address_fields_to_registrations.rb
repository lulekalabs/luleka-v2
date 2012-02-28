class AddAddressFieldsToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :city, :string
    add_column :registrations, :postal_code, :string
    add_column :registrations, :region_code, :string
    add_column :registrations, :metrocode, :string
  end
end
