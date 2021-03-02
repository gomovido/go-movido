class CreateMobiles < ActiveRecord::Migration[6.0]
  def change
    create_table :mobiles do |t|

      t.string :offer_type
      t.string :name
      t.string :area
      t.float :price
      t.integer :time_contract
      t.float :sim_card_price
      t.boolean :active, default: false
      t.boolean :sim_needed, default: false
      t.integer :data
      t.string :data_unit
      t.integer :call
      t.references :category, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
