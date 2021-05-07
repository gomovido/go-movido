class AddAmountToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :amount, :integer
  end
end
