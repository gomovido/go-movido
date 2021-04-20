class AddCoordinatesToFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    add_column :flat_preferences, :coordinates, :text, array: true, default: []
  end
end
