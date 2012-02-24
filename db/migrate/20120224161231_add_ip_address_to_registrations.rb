class AddIpAddressToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :ip, :string
  end
end
