class CreateHouseDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :house_details do |t|
      t.references :house, null: false, foreign_key: true
      t.integer :tenants
      t.integer :size
      t.string :address
      t.datetime :contract_starting_date

      t.timestamps
    end
  end
end
