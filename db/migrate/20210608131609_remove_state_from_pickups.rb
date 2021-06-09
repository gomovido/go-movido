class RemoveStateFromPickups < ActiveRecord::Migration[6.1]
  def change
    remove_column :pickups, :state
    add_column :pickups, :uncomplete, :boolean, default: false
  end
end
