class AddPaidAmountToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :paid_amount, :integer
  end
end
