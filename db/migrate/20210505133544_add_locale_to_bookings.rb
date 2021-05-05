class AddLocaleToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :locale, :string
  end
end
