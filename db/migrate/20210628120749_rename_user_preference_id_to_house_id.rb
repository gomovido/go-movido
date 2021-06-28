class RenameUserPreferenceIdToHouseId < ActiveRecord::Migration[6.1]
  def change
    rename_column :carts, :user_preference_id, :house_id
    rename_column :user_services, :user_preference_id, :house_id
  end
end
