class RemoveColumnsFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :birthdate, :date
    remove_column :users, :birth_city, :string
    remove_column :users, :phone, :string
  end
end
