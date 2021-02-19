class ChangeCountryToCountryNameInProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :country, :country_name
  end
end
