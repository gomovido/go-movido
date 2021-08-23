class AddTermsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :terms, :boolean
  end
end
