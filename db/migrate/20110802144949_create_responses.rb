class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer  "kase_id"
      t.integer  "person_id"
      t.text     "description"
      t.decimal  "latitude", :precision => 15, :scale => 10
      t.decimal  "longitude", :precision => 15, :scale => 10
      t.string   "status", :default => "created", :null => false
      t.string   "language_code", :limit => 2
      t.string   "country_code", :limit => 2
      t.integer  "votes_count", :default => 0
      t.integer  "up_votes_count"
      t.integer  "down_votes_count"
      t.integer  "votes_sum", :default => 0
      t.integer  "comments_count", :default => 0
      t.datetime "published_at"
      t.datetime "activated_at"
      t.datetime "suspended_at"
      t.datetime "deleted_at"
      t.datetime "accepted_at"
      t.timestamps
    end
    add_index :responses, "kase_id"
    add_index :responses, "person_id"
    add_index :responses, "language_code"
    add_index :responses, "country_code"
    add_index :responses, "status"
    add_index :responses, "votes_count"
    add_index :responses, "comments_count"
    add_index :responses, "created_at"
  end
end
