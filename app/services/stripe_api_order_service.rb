class StripeApiOrderService
  def initialize(params)
    @user_id = params[:user_id]
    @subscription_id = params[:subscription_id]
    @order_id = params[:stripe_order_id]
    @stripe_token = params[:stripe_token]
  end

  def init_order
    response = StripeApiCustomerService.new(user_id: @user_id).retrieve_or_create
    response.id ? create_or_retrieve(response.id, @subscription_id) : response
  end

  def create_or_retrieve(customer_id, subscription_id)
    order = Order.find_by(subscription_id: subscription_id)
    order ? retrieve(order.stripe_id) : create(customer_id, subscription_id)
  end

  def create(customer_id, subscription_id)
    subscription = Subscription.find(subscription_id)
    begin
      stripe_order = Stripe::Order.create({
        customer: customer_id,
        currency: subscription.product.country.currency,
        email: subscription.address.user.email,
        items: [
          {
            type: 'sku',
            parent: subscription.product.stripe_id
          },
        ],
        shipping: {
          name: subscription.address.user.full_name,
          address: {
            line1: subscription.address.street,
            city: subscription.address.city,
            country: subscription.address.country.code.upcase,
            postal_code: subscription.address.zipcode
          },
        },
      })
      return { stripe_order: stripe_order, error: nil }
    rescue Stripe::StripeError => error
      return { stripe_order: nil, error: error }
    end
  end

  def retrieve(order_id)
    begin
      stripe_order = Stripe::Order.retrieve(
        order_id,
      )
      return { stripe_order: stripe_order, error: nil }
    rescue Stripe::StripeError => error
      return { stripe_order: nil, error: error }
    end
  end

  def proceed_payment
    begin
      order = Stripe::Order.pay(
        @order_id,
        { source: @stripe_token },
      )
      return { stripe_order: order, error: nil }
    rescue  Stripe::StripeError => error
      return { stripe_order: nil, error: error }
    end
  end

end
