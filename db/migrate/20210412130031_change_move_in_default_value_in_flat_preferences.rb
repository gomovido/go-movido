class ChangeMoveInDefaultValueInFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    change_column_default :flat_preferences, :move_in, nil
  end
end
