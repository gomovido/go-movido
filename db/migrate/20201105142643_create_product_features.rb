class CreateProductFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :product_features do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end
