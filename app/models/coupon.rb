class Coupon < ApplicationRecord
  has_many :charges, dependent: :nullify
  has_many :subscriptions, dependent: :nullify
  after_create :create_stripe_coupon
  after_update :update_stripe_coupon

  def create_stripe_coupon
    return unless stripe_id.nil?

    response = StripeApiCouponService.new(coupon_id: id).create
    update(stripe_id: response[:coupon_id]) if response[:coupon_id]
  end

  def update_stripe_coupon
    StripeApiCouponService.new(coupon_id: id).update
  end
end
