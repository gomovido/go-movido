class AddIndexToCompaniesName < ActiveRecord::Migration[6.1]
  def change
    add_index :companies, :name, unique: true
  end
end
