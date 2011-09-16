class CreateKases < ActiveRecord::Migration
  def change
    create_table :kases do |t|
      t.string   "uid"
      t.integer  "person_id"
      t.string   "title"
      t.text     "description"
      t.string   "slug"
      t.string   "type"
      t.string   "language_code", :limit => 2
      t.string   "country_code", :limit => 2
      t.decimal  "latitude", :precision => 15, :scale => 10
      t.decimal  "longitude", :precision => 15, :scale => 10
      t.string   "status", :default => "created", :null => false
      t.integer  "views_count", :default => 0
      t.integer  "visits_count", :default => 0
      t.integer  "comments_count", :default => 0
      t.integer  "votes_count", :default => 0
      t.integer  "up_votes_count", :default => 0
      t.integer  "down_votes_count", :default => 0
      t.integer  "votes_sum", :default => 0
      t.integer  "responses_count", :default => 0
      t.integer  "followers_count", :default => 0
      t.timestamps
    end
    add_index :kases, "uid"
    add_index :kases, "person_id"
    add_index :kases, "type"
    add_index :kases, "language_code"
    add_index :kases, "country_code"
    add_index :kases, "status"
    add_index :kases, "slug"
    add_index :kases, "views_count"
    add_index :kases, "visits_count"
    add_index :kases, "comments_count"
    add_index :kases, "votes_count"
    add_index :kases, "up_votes_count"
    add_index :kases, "down_votes_count"
    add_index :kases, "votes_sum"
    add_index :kases, "responses_count"
    add_index :kases, "followers_count"
    add_index :kases, "created_at"
    add_index :kases, "latitude"
    add_index :kases, "longitude"
  end
end
