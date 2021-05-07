class SubscriptionReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex do
    set_browser
    @subscription = GlobalID::Locator.locate_signed(element.dataset.signed_id)
  end

  def submit
    coupon = Coupon.find_by(name: subscription_params[:coupon])
    if coupon&.campaign_is_discount?
      response = manage_discount_coupon(@subscription, coupon)
    elsif coupon&.campaign_is_voucher?
      response = manage_voucher_coupon(@subscription, coupon)
    else
      response = { error: 'invalid_code' }
    end
    morph ".coupon-input", (with_locale { render(partial: "subscriptions/#{device}/coupon", locals: { subscription: @subscription, response: response }) })
  end

  def manage_voucher_coupon(subscription, coupon)
    if subscription.coupon.nil? && coupon&.products&.include?(subscription.product) && coupon.livemode
      if subscription.update(coupon: coupon)
        return { error: nil, valid: true }
      else
        return { error: 'invalid_request_error' }
      end
    end
  end

  def manage_discount_coupon(subscription, coupon)
    if subscription.coupon.nil? && coupon&.products&.include?(subscription.product) && coupon.livemode
      response = StripeApiOrderService.new(stripe_order_id: subscription.stripe_id, coupon_id: coupon.stripe_id).apply_coupon
      if response[:stripe_order]
        order = response[:stripe_order]
        subscription.update(coupon: coupon, amount: order.amount)
        return { error: nil, valid: true }
      else
        return { error: 'invalid_request_error' }
      end
    else
      return { error: 'not_available_product' }
    end
  end

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end


  def subscription_params
    params.require(:subscription).permit(:coupon)
  end
end
