class StripeApiBillingService
  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
    @subscription_id = params[:subscription_id]
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

  def proceed_payment
    order = Order.find(@order_id)
    response = create_or_update_customer
    if response[:error].nil?
      response = proceed_activation_payment unless order.paid?
      response[:error].nil? ? response = create_plan : response[:error]
      response[:error].nil? ? create_subscription(response[:plan]) : response[:error]
    else
      response
    end
  end

  def create_or_update_customer
    order = Order.find(@order_id)
    order.user.stripe_id ? update_customer(order.user.stripe_id) : create_customer
  end

  def create_customer
    order = Order.find(@order_id)
    begin
      customer = Stripe::Customer.create({
                                           email: order.user.email,
                                           description: "Customer ##{order.user.id} - #{order.user.email}",
                                           name: "#{order.user.first_name} #{order.user.last_name}",
                                           source: @stripe_token
                                         })
      order.user.update(stripe_id: customer.id)
      { error: nil, customer: customer }
    rescue Stripe::StripeError => e
      { error: e, customer: nil }
    end
  end

  def proceed_activation_payment
    order = Order.find(@order_id)
    if order.total_activation_amount.positive?
      create_charge(order)
    else
      order.update(state: 'succeeded')
      { order: order, error: nil }
    end
  end

  def create_charge(order)
    stripe_charge = Stripe::Charge.create({
                                            amount: order.total_activation_amount,
                                            currency: order.currency,
                                            customer: order.user.stripe_id,
                                            description: "This is payment for user #{order.user.email} - Order #-#{order.id}"
                                          })
    update_order(stripe_charge)
    { stripe_charge: stripe_charge, error: nil }
  rescue Stripe::StripeError => e
    return { stripe_charge: nil, error: e }
  end

  def update_order(stripe_charge)
    order = Order.find(@order_id)
    charge = order.charge || Charge.new
    charge.update(state: stripe_charge.status, stripe_charge_id: stripe_charge.id)
    order.update(state: 'succeeded', charge: charge)
  end

  def create_subscription(plan)
    order = Order.find(@order_id)
    coupon = Coupon.find_by(name: '20-percent-settle-in-pack')
    order.subscription.starting_date.today? || order.subscription.starting_date.past? ? starting_date = (Time.zone.now + 5.seconds).to_i : starting_date = order.subscription.starting_date.to_i
    subscription_params = {
      customer: order.user.stripe_id,
      items: [
        { price: plan.id }
      ],
      trial_end: starting_date
    }
    subscription_params[:coupon] = coupon.stripe_id if order.affiliate_link.present?
    begin
      subscription = Stripe::Subscription.create(subscription_params)
      order.subscription.update(stripe_id: subscription.id)
      order.subscription.update(coupon: coupon) if order.affiliate_link.present?
      { subscription: subscription, error: nil }
    rescue Stripe::StripeError => e
      { subscription: nil, error: e }
    end
  end

  def create_plan
    order = Order.find(@order_id)
    begin
      plan = Stripe::Plan.create({
                                   amount: order.total_subscription_amount,
                                   currency: order.currency,
                                   interval: 'month',
                                   product: { name: "movido subscription for services #{order.products.map { |p| p.company.name }}" }
                                 })
      { plan: plan, error: nil }
    rescue Stripe::StripeError => e
      { plan: nil, error: e }
    end
  end

  def update_customer(stripe_id)
    customer = Stripe::Customer.update(
      stripe_id,
      source: @stripe_token
    )
    { customer: customer, error: nil }
  rescue Stripe::StripeError => e
    { customer: nil, error: e }
  end
end
