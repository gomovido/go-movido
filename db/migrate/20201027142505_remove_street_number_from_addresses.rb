class RemoveStreetNumberFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :street_number
  end
end
