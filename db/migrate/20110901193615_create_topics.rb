class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string   "uid"
      t.string   "name"
      t.text     "description"
      t.string   "language_code", :limit => 2
      t.string   "country_code", :limit => 2
      t.string   "slug"
      t.string   "status", :default => "created", :null => false
      t.decimal  "latitude", :precision => 15, :scale => 10
      t.decimal  "longitude", :precision => 15, :scale => 10
      t.timestamps
    end
    add_index :topics, "uid"
    add_index :topics, "slug"
    add_index :topics, "status"
    add_index :topics, "language_code"
    add_index :topics, "country_code"
    add_index :topics, "latitude"
    add_index :topics, "longitude"
  end
end
