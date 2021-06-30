class AddPackToCategories < ActiveRecord::Migration[6.1]
  def change
    add_reference :categories, :pack, foreign_key: true
  end
end
