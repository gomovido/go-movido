class AddDeliveryAddressToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :delivery_address, :string
  end
end
