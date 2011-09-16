# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20110901193615) do

  create_table "comments", :force => true do |t|
    t.string   "uid"
    t.integer  "parent_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "message"
    t.decimal  "latitude",                      :precision => 15, :scale => 10
    t.decimal  "longitude",                     :precision => 15, :scale => 10
    t.string   "status",                                                        :default => "created", :null => false
    t.string   "language_code",    :limit => 2
    t.string   "country_code",     :limit => 2
    t.datetime "published_at"
    t.datetime "suspended_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["country_code"], :name => "index_comments_on_country_code"
  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["language_code"], :name => "index_comments_on_language_code"
  add_index "comments", ["latitude"], :name => "index_comments_on_latitude"
  add_index "comments", ["longitude"], :name => "index_comments_on_longitude"
  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"
  add_index "comments", ["status"], :name => "index_comments_on_status"
  add_index "comments", ["uid"], :name => "index_comments_on_uid"

  create_table "contexts", :force => true do |t|
    t.integer  "kase_id"
    t.integer  "tier_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contexts", ["kase_id"], :name => "index_contexts_on_kase_id"
  add_index "contexts", ["tier_id"], :name => "index_contexts_on_tier_id"
  add_index "contexts", ["topic_id"], :name => "index_contexts_on_topic_id"

  create_table "kases", :force => true do |t|
    t.string   "uid"
    t.integer  "person_id"
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.string   "type"
    t.string   "language_code",    :limit => 2
    t.string   "country_code",     :limit => 2
    t.decimal  "latitude",                      :precision => 15, :scale => 10
    t.decimal  "longitude",                     :precision => 15, :scale => 10
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
  add_index "kases", ["created_at"], :name => "index_kases_on_created_at"
  add_index "kases", ["down_votes_count"], :name => "index_kases_on_down_votes_count"
  add_index "kases", ["followers_count"], :name => "index_kases_on_followers_count"
  add_index "kases", ["language_code"], :name => "index_kases_on_language_code"
  add_index "kases", ["latitude"], :name => "index_kases_on_latitude"
  add_index "kases", ["longitude"], :name => "index_kases_on_longitude"
  add_index "kases", ["person_id"], :name => "index_kases_on_person_id"
  add_index "kases", ["responses_count"], :name => "index_kases_on_responses_count"
  add_index "kases", ["slug"], :name => "index_kases_on_slug"
  add_index "kases", ["status"], :name => "index_kases_on_status"
  add_index "kases", ["type"], :name => "index_kases_on_type"
  add_index "kases", ["uid"], :name => "index_kases_on_uid"
  add_index "kases", ["up_votes_count"], :name => "index_kases_on_up_votes_count"
  add_index "kases", ["views_count"], :name => "index_kases_on_views_count"
  add_index "kases", ["visits_count"], :name => "index_kases_on_visits_count"
  add_index "kases", ["votes_count"], :name => "index_kases_on_votes_count"
  add_index "kases", ["votes_sum"], :name => "index_kases_on_votes_sum"

  create_table "people", :force => true do |t|
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "slug"
    t.string   "gender",                     :limit => 1
    t.string   "url"
    t.text     "description"
    t.decimal  "latitude",                                 :precision => 15, :scale => 10
    t.decimal  "longitude",                                :precision => 15, :scale => 10
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
  add_index "people", ["latitude"], :name => "index_people_on_latitude"
  add_index "people", ["longitude"], :name => "index_people_on_longitude"
  add_index "people", ["received_down_votes_count"], :name => "index_people_on_received_down_votes_count"
  add_index "people", ["received_up_votes_count"], :name => "index_people_on_received_up_votes_count"
  add_index "people", ["received_votes_count"], :name => "index_people_on_received_votes_count"
  add_index "people", ["responses_count"], :name => "index_people_on_responses_count"
  add_index "people", ["slug"], :name => "index_people_on_slug"
  add_index "people", ["uid"], :name => "index_people_on_uid"
  add_index "people", ["views_count"], :name => "index_people_on_views_count"
  add_index "people", ["visits_count"], :name => "index_people_on_visits_count"

  create_table "responses", :force => true do |t|
    t.string   "uid"
    t.integer  "kase_id"
    t.integer  "person_id"
    t.text     "description"
    t.decimal  "latitude",                      :precision => 15, :scale => 10
    t.decimal  "longitude",                     :precision => 15, :scale => 10
    t.string   "status",                                                        :default => "created", :null => false
    t.string   "language_code",    :limit => 2
    t.string   "country_code",     :limit => 2
    t.integer  "votes_count",                                                   :default => 0
    t.integer  "up_votes_count"
    t.integer  "down_votes_count"
    t.integer  "votes_sum",                                                     :default => 0
    t.integer  "comments_count",                                                :default => 0
    t.datetime "published_at"
    t.datetime "activated_at"
    t.datetime "suspended_at"
    t.datetime "deleted_at"
    t.datetime "accepted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["comments_count"], :name => "index_responses_on_comments_count"
  add_index "responses", ["country_code"], :name => "index_responses_on_country_code"
  add_index "responses", ["created_at"], :name => "index_responses_on_created_at"
  add_index "responses", ["kase_id"], :name => "index_responses_on_kase_id"
  add_index "responses", ["language_code"], :name => "index_responses_on_language_code"
  add_index "responses", ["latitude"], :name => "index_responses_on_latitude"
  add_index "responses", ["longitude"], :name => "index_responses_on_longitude"
  add_index "responses", ["person_id"], :name => "index_responses_on_person_id"
  add_index "responses", ["status"], :name => "index_responses_on_status"
  add_index "responses", ["uid"], :name => "index_responses_on_uid"
  add_index "responses", ["votes_count"], :name => "index_responses_on_votes_count"

  create_table "tiers", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.text     "description"
    t.string   "slug"
    t.string   "url"
    t.string   "status",                                                     :default => "created", :null => false
    t.decimal  "latitude",                   :precision => 15, :scale => 10
    t.decimal  "longitude",                  :precision => 15, :scale => 10
    t.string   "language_code", :limit => 2
    t.string   "country_code",  :limit => 2
    t.integer  "kases_count",                                                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tiers", ["country_code"], :name => "index_tiers_on_country_code"
  add_index "tiers", ["kases_count"], :name => "index_tiers_on_kases_count"
  add_index "tiers", ["language_code"], :name => "index_tiers_on_language_code"
  add_index "tiers", ["latitude"], :name => "index_tiers_on_latitude"
  add_index "tiers", ["longitude"], :name => "index_tiers_on_longitude"
  add_index "tiers", ["slug"], :name => "index_tiers_on_slug"
  add_index "tiers", ["status"], :name => "index_tiers_on_status"
  add_index "tiers", ["uid"], :name => "index_tiers_on_uid"

  create_table "topics", :force => true do |t|
    t.string   "uid"
    t.string   "name"
    t.text     "description"
    t.string   "language_code", :limit => 2
    t.string   "country_code",  :limit => 2
    t.string   "slug"
    t.string   "status",                                                     :default => "created", :null => false
    t.decimal  "latitude",                   :precision => 15, :scale => 10
    t.decimal  "longitude",                  :precision => 15, :scale => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["country_code"], :name => "index_topics_on_country_code"
  add_index "topics", ["language_code"], :name => "index_topics_on_language_code"
  add_index "topics", ["latitude"], :name => "index_topics_on_latitude"
  add_index "topics", ["longitude"], :name => "index_topics_on_longitude"
  add_index "topics", ["slug"], :name => "index_topics_on_slug"
  add_index "topics", ["status"], :name => "index_topics_on_status"
  add_index "topics", ["uid"], :name => "index_topics_on_uid"

end
