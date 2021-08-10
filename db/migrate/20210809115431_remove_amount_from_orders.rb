class RemoveAmountFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :amount
  end
end
