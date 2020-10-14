class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :country
      t.string :city
      t.string :zipcode
      t.string :street
      t.string :street_number
      t.string :floor
      t.string :internet_status
      t.string :phone
      t.string :mobile_phone
      t.string :building
      t.string :stairs
      t.string :door
      t.string :gate_code

      t.timestamps
    end
  end
end
