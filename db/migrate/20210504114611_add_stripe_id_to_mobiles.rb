class AddStripeIdToMobiles < ActiveRecord::Migration[6.1]
  def change
    add_column :mobiles, :stripe_id, :string
  end
end
