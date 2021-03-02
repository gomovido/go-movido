class RemoveProductsFromProductFeatures < ActiveRecord::Migration[6.0]
  def change
    remove_reference :product_features, :product, null: false, foreign_key: true
  end
end
