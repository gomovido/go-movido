class RemovePhonedFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :phoned
  end
end
