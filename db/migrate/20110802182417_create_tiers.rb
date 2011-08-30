class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers do |t|
      t.string   "uuid"
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
      t.integer  "members_count", :default => 0
      t.integer  "topics_count", :default => 0
      t.integer  "people_count", :default => 0
      t.string   "twitter_name"
      t.timestamps
    end
  end
end
