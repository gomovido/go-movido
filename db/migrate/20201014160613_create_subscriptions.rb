class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.references :product, null: false, foreign_key: true
      t.date :start_date
      t.boolean :state
      t.references :address, null: false, foreign_key: true
      t.references :billing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
