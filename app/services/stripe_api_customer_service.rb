class StripeApiCustomerService

  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
    @user_id = params[:user_id]
  end

  def create_or_update_customer
    order = Order.find(@order_id)
    order.user.stripe_id ? update : create
  end

  def create
    order = Order.find(@order_id)
    begin
      customer = Stripe::Customer.create({
                                           email: order.user.email,
                                           description: "Customer ##{order.user.id} - #{order.user.email}",
                                           name: "#{order.user.first_name} #{order.user.last_name}",
                                           source: @stripe_token
                                         })
      { error: nil, customer: customer }
    rescue Stripe::StripeError => e
      { error: e, customer: nil }
    end
  end

  def update
    order = Order.find(@order_id)
    begin
      customer = Stripe::Customer.update(
        order.user.stripe_id,
        source: @stripe_token
      )
      { customer: customer, error: nil }
    rescue Stripe::StripeError => e
      { customer: nil, error: e }
    end
  end

  def create_without_source
    user = User.find(@user_id)
    begin
      customer = Stripe::Customer.create({
                                           email: user.email,
                                           description: "Customer ##{user.id} - #{user.email}",
                                           name: "#{user.first_name} #{user.last_name}"
                                         })
      { error: nil, customer: customer }
    rescue Stripe::StripeError => e
      { error: e, customer: nil }
    end
  end

end
