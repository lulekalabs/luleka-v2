class RanemColumnIpInRegistrations < ActiveRecord::Migration
  def up
    rename_column :registrations, :ip, :ip_address
  end

  def down
    rename_column :registrations, :ip_address, :ip
  end
end
