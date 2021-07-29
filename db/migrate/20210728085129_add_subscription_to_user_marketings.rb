class AddSubscriptionToUserMarketings < ActiveRecord::Migration[6.1]
  def change
    add_column :user_marketings, :subscribed, :boolean, default: true
  end
end
