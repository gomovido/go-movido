class AddWifiReferencesToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscriptions, :wifi, null: true, foreign_key: true
  end
end
