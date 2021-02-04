class RemoveSpecialOfferFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :special_offer
  end
end
