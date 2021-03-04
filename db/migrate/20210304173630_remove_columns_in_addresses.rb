class RemoveColumnsInAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :internet_status, :string
    remove_column :addresses, :mobile_phone, :string
  end
end
