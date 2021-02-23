class AddMobileReferencesToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscriptions, :mobile, null: true, foreign_key: true
  end
end
