class AddBouncedToOrderMarketings < ActiveRecord::Migration[6.1]
  def change
    add_column :order_marketings, :bounced, :boolean
  end
end
