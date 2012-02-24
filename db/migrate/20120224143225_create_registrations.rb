class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.column :email, :string
      t.column :language_code, :string, :limit => 2
      t.column :country_code, :string, :limit => 2
      t.timestamps
    end
    add_index :registrations, :email, :unique => true
  end
end
