class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.references :company, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.string :sku
      t.float :activation_price
      t.float :subscription_price
      t.string :currency
      t.text :description

      t.timestamps
    end
  end
end
