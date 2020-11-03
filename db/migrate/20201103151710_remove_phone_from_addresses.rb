class RemovePhoneFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :phone
  end
end
