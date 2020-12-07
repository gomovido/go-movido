class AddOpenToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :open, :boolean
  end
end
