class AddUndiscountedPriceToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :undiscounted_price, :float
  end
end
