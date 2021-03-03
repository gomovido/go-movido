class AddSortIdToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :sort_id, :integer
  end
end
