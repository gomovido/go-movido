class StripeApiBillingService
  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
  end


  def proceed_payment
    order = Order.find(@order_id)
    if order.user.stripe_id
      response = update_customer(order.user.stripe_id, @stripe_token)
    else
      response = create_customer
    end
    if response[:error].nil?
      order.user.update(stripe_id: response[:customer].id)
      response = create_charge if !order.paid?
      update_order(response[:stripe_charge]) if response[:error].nil?
      response = create_plan
      create_subscription(response[:plan]) if response[:error].nil?
    else
      response
    end
  end

  def update_order(stripe_charge)
    order = Order.find(@order_id)
    charge = order.charge || Charge.new
    charge.update(state: stripe_charge.status, stripe_charge_id: stripe_charge.id)
    order.update(state: 'succeeded', charge: charge)
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
      {error: nil, customer: customer}
    rescue Stripe::StripeError => error
      {error: error, customer: nil}
    end

  end


  def create_charge
    order = Order.find(@order_id)
    begin
      stripe_charge = Stripe::Charge.create({
                                              amount: order.total_activation_amount,
                                              currency: order.currency,
                                              customer: order.user.stripe_id,
                                              description: "This is payment for user #{order.user.email} - Order #-#{order.id}"
                                            })
      {stripe_charge: stripe_charge, error: nil}
    rescue Stripe::StripeError => e
      return { stripe_charge: nil, error: error }
    end
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



  def update_customer(stripe_id, stripe_token)
    begin
      customer = Stripe::Customer.update(
        stripe_id,
        source: stripe_token,
      )
      {customer: customer, error: nil}
    rescue Stripe::StripeError => error
      {customer: nil, error: error}
    end

  end



end
