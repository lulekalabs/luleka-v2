class ChangeLanguageCodeToLocalForRegistrations < ActiveRecord::Migration
  def up
    rename_column :registrations, :language_code, :locale
    change_column :registrations, :locale, :string, :limit => 8
  end

  def down
    change_column :registrations, :locale, :string, :limit => 2
    rename_column :registrations, :locale, :language_code
  end
end
