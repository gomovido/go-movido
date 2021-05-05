class AddMoreStripeIdToWifis < ActiveRecord::Migration[6.1]
  def change
    add_column :wifis, :stripe_id, :string
  end
end
