class StripeApiCouponService
  def initialize(params)
    @coupon_id = params[:coupon_id]
  end

  def create
    coupon = Coupon.find(@coupon_id)
    begin
      discount = Stripe::Coupon.create(
        duration: 'once',
        name: coupon.name,
        percent_off: coupon.percent_off
      )
      return { coupon_id: discount.id, error: nil }
    rescue Stripe::StripeError, Stripe::InvalidRequestError => e
      return { coupon_id: nil, error: e }
    end
  end

  def update
    coupon = Coupon.find(@coupon_id)
    begin
      discount = Stripe::Coupon.update(coupon.stripe_id, { name: coupon.name })
      return { coupon_id: discount.id, error: nil }
    rescue Stripe::StripeError, Stripe::InvalidRequestError => e
      return { coupon_id: nil, error: e }
    end
  end
end
