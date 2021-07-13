class CreateOrderMarketings < ActiveRecord::Migration[6.1]
  def change
    create_table :order_marketings do |t|
      t.string :title
      t.string :step
      t.boolean :sent
      t.references :order, null: false, foreign_key: true
      t.timestamps
    end
  end
end
