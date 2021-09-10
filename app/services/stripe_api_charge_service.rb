class StripeApiChargeService
  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
    @customer_id = params[:customer_id]
    @amount = params[:amount]
  end

  def create
    order = Order.find(@order_id)
    begin
      stripe_charge = Stripe::Charge.create({
                                              amount: @amount.to_i,
                                              currency: order.currency,
                                              customer: @customer_id,
                                              description: "This is payment for user #{order.user.email} - Order #-#{order.id}"
                                            })
      return { stripe_charge: stripe_charge, error: nil }
    rescue Stripe::StripeError => e
      return { stripe_charge: nil, error: e }
    end
  end

end
