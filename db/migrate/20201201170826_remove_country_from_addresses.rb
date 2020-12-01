class RemoveCountryFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :country
  end
end
