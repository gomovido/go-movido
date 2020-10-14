class AddDefaultValuestoUsers < ActiveRecord::Migration[6.0]
  def change
     change_column_default :users, :housed, false
     change_column_default :users, :already_moved, false
  end
end
