class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.string :state
      t.string :stripe_charge_id

      t.timestamps
    end
  end
end
