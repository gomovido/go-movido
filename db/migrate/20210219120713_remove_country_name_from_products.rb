class RemoveCountryNameFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :country_name, :string
  end
end
