class AddCountryToFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    add_column :flat_preferences, :country, :string
  end
end
