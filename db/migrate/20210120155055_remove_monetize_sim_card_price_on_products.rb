class RemoveMonetizeSimCardPriceOnProducts < ActiveRecord::Migration[6.0]
  def change
    remove_monetize :products, :sim_card_price
  end
end
