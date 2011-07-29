# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110729210230) do

  create_table "kases", :force => true do |t|
    t.integer  "person_id"
    t.string   "title"
    t.string   "slug"
    t.string   "type"
    t.text     "description"
    t.string   "language_code",    :limit => 2
    t.string   "country_code",     :limit => 2
    t.decimal  "lat",                           :precision => 15, :scale => 10
    t.decimal  "lng",                           :precision => 15, :scale => 10
    t.string   "status",                                                        :default => "created", :null => false
    t.integer  "views_count",                                                   :default => 0
    t.integer  "visits_count",                                                  :default => 0
    t.integer  "comments_count",                                                :default => 0
    t.integer  "votes_count",                                                   :default => 0
    t.integer  "up_votes_count",                                                :default => 0
    t.integer  "down_votes_count",                                              :default => 0
    t.integer  "votes_sum",                                                     :default => 0
    t.integer  "responses_count",                                               :default => 0
    t.integer  "followers_count",                                               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kases", ["comments_count"], :name => "index_kases_on_comments_count"
  add_index "kases", ["country_code"], :name => "index_kases_on_country_code"
  add_index "kases", ["down_votes_count"], :name => "index_kases_on_down_votes_count"
  add_index "kases", ["followers_count"], :name => "index_kases_on_followers_count"
  add_index "kases", ["language_code"], :name => "index_kases_on_language_code"
  add_index "kases", ["person_id"], :name => "index_kases_on_person_id"
  add_index "kases", ["responses_count"], :name => "index_kases_on_responses_count"
  add_index "kases", ["slug"], :name => "index_kases_on_slug"
  add_index "kases", ["status"], :name => "index_kases_on_status"
  add_index "kases", ["type"], :name => "index_kases_on_type"
  add_index "kases", ["up_votes_count"], :name => "index_kases_on_up_votes_count"
  add_index "kases", ["views_count"], :name => "index_kases_on_views_count"
  add_index "kases", ["visits_count"], :name => "index_kases_on_visits_count"
  add_index "kases", ["votes_count"], :name => "index_kases_on_votes_count"
  add_index "kases", ["votes_sum"], :name => "index_kases_on_votes_sum"

  create_table "people", :force => true do |t|
    t.string   "uuid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "slug"
    t.string   "gender",                     :limit => 1
    t.string   "url"
    t.text     "description"
    t.decimal  "lat",                                      :precision => 15, :scale => 10
    t.decimal  "lng",                                      :precision => 15, :scale => 10
    t.string   "twitter_name",               :limit => 60
    t.integer  "followers_count",                                                          :default => 0
    t.integer  "views_count",                                                              :default => 0
    t.integer  "visits_count",                                                             :default => 0
    t.integer  "kases_count",                                                              :default => 0
    t.integer  "responses_count",                                                          :default => 0
    t.integer  "received_votes_count",                                                     :default => 0
    t.integer  "received_up_votes_count",                                                  :default => 0
    t.integer  "received_down_votes_count",                                                :default => 0
    t.boolean  "notify_on_email_newsletter",                                               :default => true,  :null => false
    t.boolean  "notify_on_new_follower",                                                   :default => false, :null => false
    t.boolean  "notify_on_any_response",                                                   :default => true,  :null => false
    t.boolean  "notify_on_any_post",                                                       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["followers_count"], :name => "index_people_on_followers_count"
  add_index "people", ["kases_count"], :name => "index_people_on_kases_count"
  add_index "people", ["received_down_votes_count"], :name => "index_people_on_received_down_votes_count"
  add_index "people", ["received_up_votes_count"], :name => "index_people_on_received_up_votes_count"
  add_index "people", ["received_votes_count"], :name => "index_people_on_received_votes_count"
  add_index "people", ["responses_count"], :name => "index_people_on_responses_count"
  add_index "people", ["slug"], :name => "index_people_on_slug"
  add_index "people", ["uuid"], :name => "index_people_on_uuid"
  add_index "people", ["views_count"], :name => "index_people_on_views_count"
  add_index "people", ["visits_count"], :name => "index_people_on_visits_count"

end
