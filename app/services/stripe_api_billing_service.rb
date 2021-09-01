class StripeApiBillingService
  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
    @subscription_id = params[:subscription_id]
    @plan_id = params[:plan_id]
  end

  def cancel_subscription
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

  def create_subscription
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

  def create_plans
    order = Order.find(@order_id)
    response = []
    order.subscription.plans.each do |plan|
      begin
        stripe_plan = Stripe::Plan.create({
                                   amount: plan.price.to_i,
                                   currency: order.currency,
                                   interval: 'month',
                                   product: { name: plan.name }
                                 })
        plan.update(stripe_id: stripe_plan.id)
        response = {plan: stripe_plan, error: nil}
      rescue Stripe::StripeError => e
        response = {plan: nil, error: e}
      end
    end
    response
  end

  def update_subscription_plan
    plan = Plan.find(@plan_id)
    if plan.stripe_id
      response = retrieve_subscription
      if response[:subscription]
        subscription = response[:subscription].items.data.filter{|a| a.plan.id == plan.stripe_id}[0]
        subscription_item_id = subscription.id if subscription
        delete_subscription_item(subscription_item_id) if subscription_item_id
        delete_service_from_subscription
      else
        delete_service_from_subscription
      end
    else
      delete_service_from_subscription
    end
  end

  def delete_service_from_subscription
    subscription = Subscription.find(@subscription_id)
    plan = Plan.find(@plan_id)
    plan.product.items.select{|i| i.cart == plan.subscription.order.cart }[0].destroy
  end

  def delete_subscription_item(subscription_item_id)
    begin
      subscription_item = Stripe::SubscriptionItem.delete( subscription_item_id )
      { subscription_item: subscription_item, error: nil }
    rescue Stripe::StripeError => e
      { subscription_item: nil, error: e }
    end
  end

  def retrieve_subscription
    subscription_stripe_id = Subscription.find(@subscription_id).stripe_id
    begin
      subscription = Stripe::Subscription.retrieve( subscription_stripe_id.to_s )
      { subscription: subscription, error: nil }
    rescue Stripe::StripeError => e
      { subscription: nil, error: e }
    end
  end

  def update_customer(stripe_id)
    begin
      customer = Stripe::Customer.update(
        stripe_id,
        source: @stripe_token
      )
      { customer: customer, error: nil }
    rescue Stripe::StripeError => e
      { customer: nil, error: e }
    end
  end

end
