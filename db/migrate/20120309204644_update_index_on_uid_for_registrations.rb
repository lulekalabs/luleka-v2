class UpdateIndexOnUidForRegistrations < ActiveRecord::Migration
  def up
    remove_index :registrations, :uid
    add_index :registrations, :uid
  end

  def down
    remove_index :registrations, :uid
    add_index :registrations, :uid, :unique => true
  end
end
