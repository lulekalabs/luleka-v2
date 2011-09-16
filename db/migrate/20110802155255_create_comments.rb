class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string   "uid"
      t.integer  "parent_id"
      t.integer  "commentable_id"
      t.string   "commentable_type"
      t.text     "message"
      t.decimal  "latitude", :precision => 15, :scale => 10
      t.decimal  "longitude", :precision => 15, :scale => 10
      t.string   "status", :default => "created", :null => false
      t.string   "language_code", :limit => 2
      t.string   "country_code", :limit  => 2
      t.datetime "published_at"
      t.datetime "suspended_at"
      t.datetime "deleted_at"
      t.timestamps
    end
    add_index :comments, "uid"
    add_index :comments, "parent_id"
    add_index :comments, "status"
    add_index :comments, "language_code"
    add_index :comments, "country_code"
    add_index :comments, ["commentable_id", "commentable_type"]
    add_index :comments, "created_at"
    add_index :comments, "latitude"
    add_index :comments, "longitude"
  end
end
