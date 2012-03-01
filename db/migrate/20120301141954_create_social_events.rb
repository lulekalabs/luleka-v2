class CreateSocialEvents < ActiveRecord::Migration
  def change
    create_table :social_events do |t|
      t.integer  "code_id", :null => false
      t.boolean  "viral", :default => false, :null => false
      t.string   "ip_address"
      t.text     "payload"
      t.datetime "created_at"
    end
    add_index :social_events, :code_id
    add_index :social_events, :created_at
  end
end
