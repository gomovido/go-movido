class AddFlatIdToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :flat_id, :string
  end
end
