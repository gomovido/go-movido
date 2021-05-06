class StripeApiOrderService
  def initialize(params)
    @user_id = params[:user_id]
    @subscription_id = params[:subscription_id]
    @order_id = params[:stripe_order_id]
    @stripe_token = params[:stripe_token]
  end

  def init_order
    response = StripeApiCustomerService.new(user_id: @user_id).retrieve_or_create
    response.id ? retrieve_or_create(response.id, @subscription_id) : response
  end

  def retrieve_or_create(customer_id, subscription_id)
    subscription = Subscription.find(subscription_id)
    subscription.stripe_id.nil? ? create(customer_id, subscription_id) : retrieve(subscription.stripe_id)
  end

  def create(customer_id, subscription_id)
    subscription = Subscription.find(subscription_id)
    begin
      # rubocop:disable Naming/VariableNumber
      stripe_order = Stripe::Order.create({
                                            customer: customer_id,
                                            currency: subscription.product.country.currency,
                                            email: subscription.address.user.email,
                                            items: [
                                              {
                                                type: 'sku',
                                                parent: subscription.product.stripe_id
                                              }
                                            ],
                                            shipping: {
                                              name: subscription.address.user.full_name,
                                              address: {
                                                line1: subscription&.address&.street || subscription&.billing&.address || '',
                                                country: subscription.address.country.code.upcase,
                                                postal_code: subscription.address.zipcode
                                              }
                                            }
                                          })
      return { stripe_order: stripe_order, error: nil }
      # rubocop:enable Naming/VariableNumber
    rescue Stripe::StripeError => e
      return { stripe_order: nil, error: e }
    end
  end

  def retrieve(order_id)
    stripe_order = Stripe::Order.retrieve(
      order_id
    )
    return { stripe_order: stripe_order, error: nil }
  rescue Stripe::StripeError => e
    return { stripe_order: nil, error: e }
  end

  def proceed_payment
    order = Stripe::Order.pay(
      @order_id,
      { source: @stripe_token }
    )
    return { stripe_order: order, error: nil }
  rescue Stripe::StripeError => e
    return { stripe_order: nil, error: e }
  end
end
