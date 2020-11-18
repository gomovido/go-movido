class AddMoreColumnsDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :data_speed, :string
    add_column :products, :setup_price, :float
    add_column :products, :tooltip, :string
  end
end
