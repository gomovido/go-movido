class AddMoveOutInFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    add_column :flat_preferences, :move_out, :date
  end
end
