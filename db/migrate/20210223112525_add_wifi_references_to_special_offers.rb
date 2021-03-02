class AddWifiReferencesToSpecialOffers < ActiveRecord::Migration[6.0]
  def change
    add_reference :special_offers, :wifi, null: true, foreign_key: true
  end
end