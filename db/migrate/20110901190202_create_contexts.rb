class CreateContexts < ActiveRecord::Migration
  def change
    create_table :contexts do |t|
      t.integer "kase_id"
      t.integer "tier_id"
      t.integer "topic_id"
      t.timestamps
    end
    add_index :contexts, "kase_id"
    add_index :contexts, "tier_id"
    add_index :contexts, "topic_id"
  end
end
