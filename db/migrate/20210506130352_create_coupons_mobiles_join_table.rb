class CreateCouponsMobilesJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :coupons, :mobiles
  end
end
