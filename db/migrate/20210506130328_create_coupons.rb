class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :stripe_id
      t.string :currency
      t.string :duration
      t.integer :duration_in_months
      t.boolean :livemode
      t.string :name
      t.float :percent_off

      t.timestamps
    end
  end
end
