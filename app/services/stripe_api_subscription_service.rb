class StripeApiSubscriptionService

  def initialize(params)
    @order_id = params[:order_id]
    @subscription_id = params[:subscription_id]
    @subscription_stripe_id = params[:subscription_stripe_id]
  end

  def create
    order = Order.find(@order_id)
    coupon = Coupon.find_by(name: '20-percent-settle-in-pack')
    order.subscription.starting_date.today? || order.subscription.starting_date.past? ? starting_date = (Time.zone.now + 5.seconds).to_i : starting_date = order.subscription.starting_date.to_i
    subscription_params = { customer: order.user.stripe_id, trial_end: starting_date }
    subscription_params[:items] = order.subscription.plans.map{|p| {price: p.stripe_id}}
    subscription_params[:coupon] = coupon.stripe_id if order.affiliate_link.present?
    begin
      subscription = Stripe::Subscription.create(subscription_params)
      { subscription: subscription, coupon_id: coupon&.id, error: nil }
    rescue Stripe::StripeError => e
      { subscription: nil, error: e }
    end
  end

  def cancel
    subscription = Subscription.find(@subscription_id)
    begin
      Stripe::Subscription.update(
        subscription.stripe_id,
        cancel_at_period_end: true,
        trial_end: (Time.zone.now + 30.days).to_i
      )
      subscription.update(state: 'cancelled')
      { subscription: subscription, error: nil }
    rescue Stripe::StripeError => e
      { subscription: nil, error: e }
    end
  end

  def retrieve
    begin
      subscription = Stripe::Subscription.retrieve( @subscription_stripe_id.to_s )
      { subscription: subscription, error: nil }
    rescue Stripe::StripeError => e
      { subscription: nil, error: e }
    end
  end

end
