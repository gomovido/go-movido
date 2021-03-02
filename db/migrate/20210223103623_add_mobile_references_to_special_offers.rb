class AddMobileReferencesToSpecialOffers < ActiveRecord::Migration[6.0]
  def change
    add_reference :special_offers, :mobile, null: true, foreign_key: true
  end
end
