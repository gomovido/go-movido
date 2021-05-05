class RemoveTableCharges < ActiveRecord::Migration[6.1]
  def change
    drop_table :charges do |t|
      t.integer :stripe_charge_id
      t.string :status
      t.references :subscription, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
