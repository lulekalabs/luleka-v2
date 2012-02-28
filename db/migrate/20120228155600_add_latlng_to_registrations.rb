class AddLatlngToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :lat, :decimal, :precision => 11, :scale => 8
    add_column :registrations, :lng, :decimal, :precision => 11, :scale => 8
  end
end
