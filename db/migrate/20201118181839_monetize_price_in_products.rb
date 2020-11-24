class MonetizePriceInProducts < ActiveRecord::Migration[6.0]
  def change
     change_table :products do |t|
      t.monetize :price
    end
  end
end
