class ChangeStartDateToMoveInInFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    rename_column :flat_preferences, :start_date, :move_in
  end
end
