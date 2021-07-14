class AddBouncedToUserMarketings < ActiveRecord::Migration[6.1]
  def change
    add_column :user_marketings, :bounced, :boolean
  end
end
