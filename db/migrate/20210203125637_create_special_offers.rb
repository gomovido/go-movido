class CreateSpecialOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :special_offers  do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
