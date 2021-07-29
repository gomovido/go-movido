class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :state
      t.string :stripe_id
      t.integer :activation_price_cents
      t.integer :subscription_price_cents
      t.references :order, null: false, foreign_key: true
      t.datetime :starting_date

      t.timestamps
    end
  end
end
