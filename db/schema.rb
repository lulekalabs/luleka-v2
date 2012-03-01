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

ActiveRecord::Schema.define(:version => 20120301143145) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "registrations", :force => true do |t|
    t.string   "email"
    t.string   "language_code", :limit => 2
    t.string   "country_code",  :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "time_zone"
    t.decimal  "lat",                        :precision => 11, :scale => 8
    t.decimal  "lng",                        :precision => 11, :scale => 8
    t.string   "city"
    t.string   "postal_code"
    t.string   "region_code"
    t.string   "metrocode"
    t.string   "type"
    t.string   "uid"
    t.string   "referrer_uid"
    t.boolean  "opt_in",                                                    :default => false, :null => false
    t.text     "fields"
    t.text     "user_data"
  end

  add_index "registrations", ["email"], :name => "index_registrations_on_email", :unique => true
  add_index "registrations", ["referrer_uid"], :name => "index_registrations_on_referrer_uid"
  add_index "registrations", ["type"], :name => "index_registrations_on_type"
  add_index "registrations", ["uid"], :name => "index_registrations_on_uid", :unique => true

  create_table "social_event_codes", :force => true do |t|
    t.string "name",  :limit => 50, :null => false
    t.string "label", :limit => 50, :null => false
  end

  create_table "social_events", :force => true do |t|
    t.integer  "code_id",                       :null => false
    t.boolean  "viral",      :default => false, :null => false
    t.string   "ip_address"
    t.text     "payload"
    t.datetime "created_at"
  end

  add_index "social_events", ["code_id"], :name => "index_social_events_on_code_id"
  add_index "social_events", ["created_at"], :name => "index_social_events_on_created_at"

  create_table "social_reports", :force => true do |t|
    t.date     "date",                                   :null => false
    t.boolean  "viral",               :default => false, :null => false
    t.integer  "liked",               :default => 0,     :null => false
    t.integer  "permissions_denied",  :default => 0,     :null => false
    t.integer  "permissions_dialog",  :default => 0,     :null => false
    t.integer  "permissions_granted", :default => 0,     :null => false
    t.integer  "registration",        :default => 0,     :null => false
    t.integer  "unique_email",        :default => 0,     :null => false
    t.integer  "unliked",             :default => 0,     :null => false
    t.integer  "view_invite_page",    :default => 0,     :null => false
    t.integer  "wall_post",           :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_reports", ["date", "viral"], :name => "index_social_reports_on_date_and_viral", :unique => true

end
