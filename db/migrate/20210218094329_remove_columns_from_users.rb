class RemoveColumnsFromUsers < ActiveRecord::Migration[6.0]

  def change
    remove_column :users, :birthdate
    remove_column :users, :birth_city
    remove_column :users, :phone
    remove_column :users, :city
    remove_column :users, :not_housed
  end
end
