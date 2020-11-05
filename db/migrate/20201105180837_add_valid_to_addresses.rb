class AddValidToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :valid, :boolean
  end
end
