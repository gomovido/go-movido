class RemoveProductsFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :subscriptions, :product, null: false, foreign_key: true
  end
end
