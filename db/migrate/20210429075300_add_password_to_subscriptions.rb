class AddPasswordToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :password, :string
  end
end
