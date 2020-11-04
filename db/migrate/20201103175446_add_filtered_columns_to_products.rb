class AddFilteredColumnsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :unlimited_data, :boolean
    add_column :products, :unlimited_call, :boolean
    add_column :products, :obligation, :boolean
  end
end
