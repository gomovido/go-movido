class AddUniqueIndexToCompaniesAndCategories < ActiveRecord::Migration[6.1]
  def change
    add_index :companies, :name, unique: true
    add_index :categories, :name, unique: true
    add_index :categories, :sku, unique: true
  end
end
