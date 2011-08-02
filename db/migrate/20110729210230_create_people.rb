class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string   "uuid"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "slug"
      t.string   "gender", :limit => 1
      t.string   "url"
      t.text     "description"
      t.decimal  "latitude", :precision => 15, :scale => 10
      t.decimal  "longitude", :precision => 15, :scale => 10
      t.string   "twitter_name", :limit => 60
      t.integer  "followers_count", :default => 0
      t.integer  "views_count", :default => 0
      t.integer  "visits_count", :default => 0
      t.integer  "kases_count", :default => 0
      t.integer  "responses_count", :default => 0
      t.integer  "received_votes_count", :default => 0
      t.integer  "received_up_votes_count", :default => 0
      t.integer  "received_down_votes_count", :default => 0
      t.boolean  "notify_on_email_newsletter", :default => true, :null => false
      t.boolean  "notify_on_new_follower", :default => false, :null => false
      t.boolean  "notify_on_any_response", :default => true, :null => false
      t.boolean  "notify_on_any_post", :default => false, :null => false
      t.timestamps
    end
    add_index :people, "uuid"
    add_index :people, "slug"
    add_index :people, "followers_count"
    add_index :people, "views_count"
    add_index :people, "visits_count"
    add_index :people, "kases_count"
    add_index :people, "responses_count"
    add_index :people, "received_votes_count"
    add_index :people, "received_up_votes_count"
    add_index :people, "received_down_votes_count"
  end
end
