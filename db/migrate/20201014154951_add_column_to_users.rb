class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :already_moved, :boolean
    add_column :users, :moving_date, :date
    add_column :users, :phone, :string
    add_column :users, :city, :string
    add_column :users, :housed, :boolean
    add_column :users, :address, :string
  end
end
