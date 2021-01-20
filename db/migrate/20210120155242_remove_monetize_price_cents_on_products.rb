class RemoveMonetizePriceCentsOnProducts < ActiveRecord::Migration[6.0]
  def change
    remove_monetize :products, :price
  end
end
