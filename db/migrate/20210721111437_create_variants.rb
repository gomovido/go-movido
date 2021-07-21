class CreateVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :variants do |t|
      t.references :product, null: false, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
