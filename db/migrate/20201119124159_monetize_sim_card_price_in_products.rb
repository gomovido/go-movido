class MonetizeSimCardPriceInProducts < ActiveRecord::Migration[6.0]
  def change

     change_table :products do |t|
      t.monetize :sim_card_price
    end
  end
end
