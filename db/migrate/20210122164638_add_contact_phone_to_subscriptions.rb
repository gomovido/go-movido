class AddContactPhoneToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :contact_phone, :string
  end
end
