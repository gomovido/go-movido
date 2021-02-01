class RemoveDeliveryFieldsFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :rating
    remove_column :products, :reviews
    remove_column :products, :delivery_price
    remove_column :products, :delivery
    remove_column :products, :delivery_time
    remove_column :products, :tooltip
  end
end
