class AddMoreColumnToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :form_timer, :integer
    add_column :categories, :description, :text
    add_column :categories, :subtitle, :string
  end
end
