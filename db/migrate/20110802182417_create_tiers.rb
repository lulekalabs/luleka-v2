class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers do |t|
      t.string   "uid"
      t.string   "name"
      t.text     "description"
      t.string   "slug"
      t.string   "url"
      t.string   "status", :default => "created", :null => false
      t.decimal  "latitude", :precision => 15, :scale => 10
      t.decimal  "longitude", :precision => 15, :scale => 10
      t.string   "language_code", :limit => 2
      t.string   "country_code", :limit => 2
      t.integer  "kases_count", :default => 0
      t.timestamps
    end
    add_index :tiers, "uid"
    add_index :tiers, "slug"
    add_index :tiers, "status"
    add_index :tiers, "latitude"
    add_index :tiers, "longitude"
    add_index :tiers, "language_code"
    add_index :tiers, "country_code"
    add_index :tiers, "kases_count"
  end
end
