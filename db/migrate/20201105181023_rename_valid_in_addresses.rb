class RenameValidInAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :addresses, :valid, :valid_address
  end
end
