class DashboardReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def payment_details(arg)
    @cards = arg['sources']['data']
    @default_source = arg['default_source']
    morph '.cards-wrapper', render(partial: "payment_details/cards", locals: { cards: @cards, default_source: @default_source } )
  end

  def subscriptions(arg)
    @subscriptions = arg['data']
    @ongoing_subscription = @subscriptions[0]
    @order = current_user.orders.filter{|o| o&.subscription&.state == 'active'}[0]
    morph '.subscriptions-wrapper', render(partial: "dashboards/index/subscriptions", locals: { subscriptions: @subscriptions, ongoing_subscription: @ongoing_subscription, order: @order } )
  end

  def add_service_modal(arg)
    @product = Product.find(arg.to_i)
    @order = current_user.orders.filter{|o| o&.subscription&.state == 'active'}[0]
    @subscription = @order.subscription
    morph '.add-service-form', render(partial: "dashboards/modals/steps/new", locals: { product: @product, order: @order, subscription: @subscription } )
  end

  def add_service_to_subscription
    @product = Product.find(subscription_params[:product_id])
    @order = Order.find_by(id: subscription_params[:order_id], user: current_user)
    @subscription = @order.subscription
    if terms_not_checked?(subscription_params[:terms])
      @subscription.errors.add(:terms, 'You need to accept the Terms and Conditions of movido')
      morph '.add-service-form', render(partial: "dashboards/modals/steps/new", locals: { product: @product, order: @order, subscription: @subscription } )
    elsif terms_not_checked?(subscription_params[:terms_provider])
      @subscription.errors.add(:terms_provider, 'You need to accept the Terms and Conditions of providers')
      morph '.add-service-form', render(partial: "dashboards/modals/steps/new", locals: { product: @product, order: @order, subscription: @subscription } )
    else
      amount = @product.activation_price * 10 * 10
      response = StripeApiChargeService.new(amount: amount.to_i, customer_id: current_user.stripe_id, order_id: @order.id).create
      if response[:error].nil?
        init_user_services(@product)
        generate_items(@order, @product)
        init_plan(@subscription, @product)
        update_subscription(@order, @subscription)
        response = StripeApiPlanService.new(order_id: @order.id, product_id: @product.id).create
        if response[:error].nil?
          response = StripeApiSubscriptionService.new(subscription_id: @subscription.id, product_id: @product.id).update
          p "THIS IS RESPONSE"
          p response
        end
      else
        p "THIS IS RESPONSE ERROR"
        p response[:error].message
      end
    end
  end

  def update_subscription(order, subscription)
    subscription.update(
      order: order,
      subscription_price_cents: order.total_subscription_amount,
      activation_price_cents: order.total_activation_amount,
      starting_date: current_user.house.house_detail.contract_starting_date,
      state: "active"
    )
  end

  def init_plan(subscription, product)
    Plan.create(
      product: product,
      subscription: subscription,
      name: "#{product.company.name} - #{product.name}".upcase,
      price: product.plan_price_cents(subscription.order.user.house),
      state: 'active'
    )
  end

  def terms_not_checked?(terms)
    terms == '0'
  end

  def init_user_services(product)
    UserService.create(service: product.service, house: current_user.house)
  end

  def generate_items(order, product)
    Item.create(cart: order.cart, product: product, order: order)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:terms, :terms_provider, :order_id, :product_id)
  end

end
