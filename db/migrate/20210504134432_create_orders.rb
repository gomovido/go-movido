class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :stripe_id
      t.string :status
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
