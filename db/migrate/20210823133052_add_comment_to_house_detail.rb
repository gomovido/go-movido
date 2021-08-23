class AddCommentToHouseDetail < ActiveRecord::Migration[6.1]
  def change
    add_column :house_details, :comment, :text
  end
end
