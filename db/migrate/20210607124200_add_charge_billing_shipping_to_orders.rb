class AddChargeBillingShippingToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :charge, null: true, foreign_key: true
    add_reference :orders, :billing, null: true, foreign_key: true
    add_reference :orders, :shipping, null: true, foreign_key: true
  end
end
