class CreateWifis < ActiveRecord::Migration[6.0]
  def change
    create_table :wifis do |t|
      t.string :name
      t.string :area
      t.float :price
      t.integer :time_contract
      t.integer :data_speed
      t.float :setup_price
      t.boolean :active
      t.references :category, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
