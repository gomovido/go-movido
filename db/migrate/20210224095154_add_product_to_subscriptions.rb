class AddProductToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscriptions, :product, polymorphic: true, null: true
  end
end
