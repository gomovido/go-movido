class RemoveProductsFromSpecialOffers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :special_offers, :product, null: false, foreign_key: true
  end
end
