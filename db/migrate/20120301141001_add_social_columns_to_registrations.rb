class AddSocialColumnsToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :type, :string
    add_column :registrations, :uid, :string
    add_column :registrations, :referrer_uid, :string
    add_column :registrations, :opt_in, :boolean, :default => false, :null => false
    add_column :registrations, :fields, :text
    add_column :registrations, :user_data, :text
    
    add_index :registrations, :type
    add_index :registrations, :uid, :unique => true
    add_index :registrations, :referrer_uid
  end
end
