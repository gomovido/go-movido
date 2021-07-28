class StripeApiBillingService
  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
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
      {error: nil, customer: customer}
    rescue Stripe::StripeError => error
      {error: error, customer: nil}
    end

  end

  def proceed_activation_payment
    order = Order.find(@order_id)
    if order.total_activation_amount > 0
      create_charge(order)
    else
      order.update(state: 'succeeded')
      {order: order, error: nil}
    end
  end

  def create_charge
    begin
      stripe_charge = Stripe::Charge.create({
                                              amount: order.total_activation_amount,
                                              currency: order.currency,
                                              customer: order.user.stripe_id,
                                              description: "This is payment for user #{order.user.email} - Order #-#{order.id}"
                                            })
      update_order(stripe_charge)
      {stripe_charge: stripe_charge, error: nil}
    rescue Stripe::StripeError => error
      return { stripe_charge: nil, error: error }
    end
  end


  def update_order(stripe_charge)
    order = Order.find(@order_id)
    charge = order.charge || Charge.new
    charge.update(state: stripe_charge.status, stripe_charge_id: stripe_charge.id)
    order.update(state: 'succeeded', charge: charge)
  end


  def create_subscription(plan)
    order = Order.find(@order_id)
    order.subscription.starting_date.today? ? starting_date = Time.now.to_i : starting_date = order.subscription.starting_date.to_i
    begin
      subscription = Stripe::Subscription.create({
        customer: order.user.stripe_id,
        items: [
          {price: plan.id},
        ],
        trial_end: starting_date
      })
      {subscription: subscription, error: nil}
    rescue Stripe::StripeError => error
      {subscription: nil, error: error}
    end
  end

  def create_plan
    order = Order.find(@order_id)
    begin
      plan = Stripe::Plan.create({
        amount: order.total_subscription_amount,
        currency: order.currency,
        interval: 'month',
        product: {name: "movido subscription for services #{order.products.map{|p| p.company.name}}"}
      })
      {plan: plan, error: nil}
    rescue Stripe::StripeError => error
      {plan: nil, error: error}
    end
  end

  def update_customer(stripe_id)
    begin
      customer = Stripe::Customer.update(
        stripe_id,
        source: @stripe_token,
      )
      {customer: customer, error: nil}
    rescue Stripe::StripeError => error
      {customer: nil, error: error}
    end

  end
end
