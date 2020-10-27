class AddActiveToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :active, :boolean
  end
end
