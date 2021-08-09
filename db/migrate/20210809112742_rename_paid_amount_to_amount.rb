class RenamePaidAmountToAmount < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :paid_amount, :amount
  end
end
