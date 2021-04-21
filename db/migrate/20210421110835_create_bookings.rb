class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.string :full_name
      t.string :email
      t.string :university
      t.string :phone
      t.string :room_type
      t.string :lease_duration
      t.text :requirements
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
