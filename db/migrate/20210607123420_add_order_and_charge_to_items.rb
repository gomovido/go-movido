class AddOrderAndChargeToItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :order, null: true, foreign_key: true
    add_reference :items, :charge, null: true, foreign_key: true
  end
end
