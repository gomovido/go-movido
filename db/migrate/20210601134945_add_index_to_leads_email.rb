class AddIndexToLeadsEmail < ActiveRecord::Migration[6.1]
  def change
    add_index :leads, :email, unique: true
  end
end
