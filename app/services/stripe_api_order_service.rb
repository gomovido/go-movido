class StripeApiOrderService
  def initialize(params)
    @user_id = params[:user_id]
    @subscription_id = params[:subscription_id]
  end


  def init_order
    response = StripeApiCustomerService.new(user_id: @user_id).retrieve_or_create
    response.id ? create_order(response.id) : response
  end


  def create_order(customer_id, subscription_id)
    subscription = Subscription.find(subscription_id)
    begin
      stripe_order = Stripe::Order.create({
        currency: 'eur',
        email: 'jenny.rosen@example.com',
        items: [
          {type: 'sku', parent: 'sku_JQCfJbKFmoZ65V'},
        ],
        shipping: {
          name: 'Jenny Rosen',
          address: {
            line1: '1234 Main Street',
            city: 'San Francisco',
            state: 'CA',
            country: 'US',
            postal_code: '94111',
          },
        },
      })
    rescue Stripe::StripeError => error
      error
    end
  end
end
