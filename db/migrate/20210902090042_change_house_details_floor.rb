class ChangeHouseDetailsFloor < ActiveRecord::Migration[6.1]
  def change
    change_column :house_details, :floor, :string
  end
end
