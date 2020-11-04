class RemoveNameColumnsFromBillings < ActiveRecord::Migration[6.0]
  def change
    remove_column :billings, :first_name
    remove_column :billings, :last_name
  end
end
