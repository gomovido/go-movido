class ChangeStateTypeForSubscriptions < ActiveRecord::Migration[6.0]
  def change
    change_column :subscriptions, :state, :string
  end
end
