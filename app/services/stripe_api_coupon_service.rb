class StripeApiCouponService

  def initialize(params)
    @coupon_id = params[:coupon_id]
  end

  def create
    coupon = Coupon.find(@coupon_id)
    begin
      discount = Stripe::Coupon.create(
        duration: coupon.duration,
        duration_in_months: coupon.duration_in_months,
        name: coupon.name,
        percent_off: coupon.percent_off,
        applies_to: { products: get_products_ids(coupon) }
      )
      return { coupon_id: discount.id, error: nil }
    rescue Stripe::StripeError, Stripe::InvalidRequestError => error
      return { coupon_id: nil, error: error }
    end
  end

  def get_products_ids(coupon)
    coupon.mobiles.map do |mobile|
      Stripe::SKU.retrieve(mobile.stripe_id).product
    end
  end


end
