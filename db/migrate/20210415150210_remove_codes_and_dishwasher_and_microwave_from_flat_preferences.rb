class RemoveCodesAndDishwasherAndMicrowaveFromFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    remove_column :flat_preferences, :codes, :text
    remove_column :flat_preferences, :dishwasher, :boolean
    remove_column :flat_preferences, :microwave, :boolean
  end
end
