class AddSpecialOfferToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :special_offer, :string
  end
end
