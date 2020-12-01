class RemoveSkuFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :sku
  end
end
