class AddCouponsToChargesAndSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_reference :charges, :coupon, null: true, foreign_key: true
    add_reference :subscriptions, :coupon, null: true, foreign_key: true
  end
end
