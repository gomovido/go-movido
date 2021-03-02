class RemoveWifisFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :subscriptions, :wifi, null: true, foreign_key: true
  end
end
