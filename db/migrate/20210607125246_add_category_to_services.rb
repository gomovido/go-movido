class AddCategoryToServices < ActiveRecord::Migration[6.1]
  def change
    add_reference :services, :category, null: false, foreign_key: true
  end
end
