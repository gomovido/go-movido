class RemoveChargeBillingAndShippingFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :charge
    remove_reference :orders, :billing
    remove_reference :orders, :shipping
  end
end
