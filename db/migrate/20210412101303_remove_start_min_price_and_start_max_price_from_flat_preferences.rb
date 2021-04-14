class RemoveStartMinPriceAndStartMaxPriceFromFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    remove_column :flat_preferences, :start_min_price, :integer
    remove_column :flat_preferences, :start_max_price, :integer
  end
end
