class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :charge, null: false, foreign_key: true
      t.references :billing, null: false, foreign_key: true
      t.references :shipping, null: false, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
