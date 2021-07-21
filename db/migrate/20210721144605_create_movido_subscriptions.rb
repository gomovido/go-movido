class CreateMovidoSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :movido_subscriptions do |t|
      t.float :price
      t.string :stripe_id

      t.timestamps
    end
  end
end
