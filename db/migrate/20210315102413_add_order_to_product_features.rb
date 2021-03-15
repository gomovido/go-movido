class AddOrderToProductFeatures < ActiveRecord::Migration[6.1]
  def change
    add_column :product_features, :order, :integer
  end
end
