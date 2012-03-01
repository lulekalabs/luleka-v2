class CreateSocialCodes < ActiveRecord::Migration
  def up
    create_table :social_event_codes, :force => true do |t|
      t.string "name",  :limit => 50, :null => false
      t.string "label", :limit => 50, :null => false
    end
  end

  def down
    drop_table :social_event_codes
  end
end
