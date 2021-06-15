class AddAffiliateLinkToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :affiliate_link, :string
  end
end
