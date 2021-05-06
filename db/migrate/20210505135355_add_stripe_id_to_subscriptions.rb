class AddStripeIdToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :stripe_id, :string
  end
end
