class AddDetailsColumnsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :delivery, :boolean
    add_column :products, :sim_card_price, :float
    add_column :products, :call_limit, :string
  end
end
