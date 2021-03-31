class CreateFlatPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :flat_preferences do |t|
      t.date :start_date, default: Date.today
      t.integer :start_min_price
      t.integer :start_max_price
      t.references :user, null: false, foreign_key: true
      t.integer :range_min_price
      t.integer :range_max_price
      t.boolean :microwave, default: false
      t.boolean :dishwasher, default: false
      t.string :location
      t.string :flat_type
      t.text :codes, array: true, default: []
      t.text :recommandations, array: true, default: []
      t.timestamps
    end
  end
end
