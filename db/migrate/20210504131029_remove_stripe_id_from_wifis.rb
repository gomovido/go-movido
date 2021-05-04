class RemoveStripeIdFromWifis < ActiveRecord::Migration[6.1]
  def change
    remove_column :wifis, :stripe_id, :string
  end
end
