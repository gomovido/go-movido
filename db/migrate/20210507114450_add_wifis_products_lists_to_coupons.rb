class AddWifisProductsListsToCoupons < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :wifis_products_list, :text, array: true, default: []
  end
end
