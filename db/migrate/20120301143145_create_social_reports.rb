class CreateSocialReports < ActiveRecord::Migration
  def change
    create_table :social_reports do |t|
      t.date    "date",                                   :null => false
      t.boolean "viral",               :default => false, :null => false
      t.integer "liked",               :default => 0,     :null => false
      t.integer "permissions_denied",  :default => 0,     :null => false
      t.integer "permissions_dialog",  :default => 0,     :null => false
      t.integer "permissions_granted", :default => 0,     :null => false
      t.integer "registration",        :default => 0,     :null => false
      t.integer "unique_email",        :default => 0,     :null => false
      t.integer "unliked",             :default => 0,     :null => false
      t.integer "view_invite_page",    :default => 0,     :null => false
      t.integer "wall_post",           :default => 0,     :null => false
      t.timestamps
    end
    add_index :social_reports, [:date, :viral], :unique => true
  end
end
