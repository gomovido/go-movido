class RemoveBillingsFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :subscriptions, :billing, null: false, foreign_key: true
  end
end
