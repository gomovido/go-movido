class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.integer :percent_off
      t.string :name
      t.string :stripe_id

      t.timestamps
    end
  end
end
