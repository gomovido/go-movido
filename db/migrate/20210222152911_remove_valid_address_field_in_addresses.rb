class RemoveValidAddressFieldInAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :valid_address, :boolean
  end
end
