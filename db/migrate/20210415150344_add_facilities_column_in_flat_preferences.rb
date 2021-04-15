class AddFacilitiesColumnInFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    add_column :flat_preferences, :facilities, :text, array: true, default: []
  end
end
