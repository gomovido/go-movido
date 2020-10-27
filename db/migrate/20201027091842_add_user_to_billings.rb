class AddUserToBillings < ActiveRecord::Migration[6.0]
  def change
    add_reference :billings, :user, null: false, foreign_key: true
  end
end
