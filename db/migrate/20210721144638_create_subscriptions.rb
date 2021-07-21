class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :state
      t.integer :price_cents
      t.references :movido_subscription, null: true, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.datetime :starting_date

      t.timestamps
    end
  end
end
