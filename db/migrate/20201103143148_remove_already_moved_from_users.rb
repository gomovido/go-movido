class RemoveAlreadyMovedFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :already_moved
    remove_column :users, :moving_date
  end
end
