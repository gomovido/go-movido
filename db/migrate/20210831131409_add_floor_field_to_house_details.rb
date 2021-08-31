class AddFloorFieldToHouseDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :house_details, :floor, :integer
  end
end
