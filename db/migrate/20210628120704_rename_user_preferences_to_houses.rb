class RenameUserPreferencesToHouses < ActiveRecord::Migration[6.1]
  def change
    rename_table :user_preferences, :houses
  end
end
