class RenameColumnonUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :city, :country
  end
end
