class CreateProductDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :product_details do |t|
      t.references :product, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
