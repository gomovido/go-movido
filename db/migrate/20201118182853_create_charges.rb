class CreateCharges < ActiveRecord::Migration[6.0]
  def change
    create_table :charges do |t|
      t.integer :stripe_charge_id
      t.string :status
      t.references :subscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
