class UpdateGeokitFieldsOnRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :metrocode
    add_column :registrations, :region_name, :string
  end

  def down
    add_column :registrations, :metrocode, :string
    remove_column :registrations, :region_name
  end
end
