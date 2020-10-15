class ChangeDefaultonUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :already_moved, nil
    change_column_default :users, :housed, nil
  end
end
