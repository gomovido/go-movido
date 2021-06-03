class CreatePickups < ActiveRecord::Migration[6.1]
  def change
    create_table :pickups do |t|
      t.references :order, null: false, foreign_key: true
      t.date :arrival
      t.string :flight_number
      t.string :airport
      t.string :state

      t.timestamps
    end
  end
end
