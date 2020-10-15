class AddColumnsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :rating, :integer
    add_column :products, :reviews, :integer
    add_column :products, :logo, :string
  end
end
