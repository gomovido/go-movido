class AddProductsListsToCoupons < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :mobiles_products_list, :text, array: true, default: []
  end
end
