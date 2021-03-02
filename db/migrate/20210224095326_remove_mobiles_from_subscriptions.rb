class RemoveMobilesFromSubscriptions < ActiveRecord::Migration[6.0]
  def change
    remove_reference :subscriptions, :mobile, null: true, foreign_key: true
  end
end
