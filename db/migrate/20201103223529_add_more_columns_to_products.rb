class AddMoreColumnsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :time_contract, :string
    add_column :products, :data_limit, :string
    add_column :products, :delivery_price, :string
    add_column :products, :delivery_time, :string
  end
end
