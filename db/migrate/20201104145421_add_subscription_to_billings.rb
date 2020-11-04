class AddSubscriptionToBillings < ActiveRecord::Migration[6.0]
  def change
    add_reference :billings, :subscription, null: false, foreign_key: true
  end
end
