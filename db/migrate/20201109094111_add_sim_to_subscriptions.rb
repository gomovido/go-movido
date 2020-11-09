class AddSimToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :sim, :string
  end
end
