class AddPaidToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :paid, :boolean, default: false
  end
end
