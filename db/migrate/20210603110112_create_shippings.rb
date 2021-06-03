class CreateShippings < ActiveRecord::Migration[6.1]
  def change
    create_table :shippings do |t|
      t.string :address
      t.text :instructions
      t.string :state
      t.string :tracking_id
      t.date :delivery_date

      t.timestamps
    end
  end
end
