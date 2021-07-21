class StripeApiChargeService
  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
  end

  def proceed_payment
    order = Order.find(@order_id)
    begin
      stripe_charge = Stripe::Charge.create({
                                              amount: order.total_activation_amount,
                                              currency: order.currency,
                                              source: @stripe_token,
                                              description: "This is payment for user #{order.user.email} - Order #-#{order.id}"
                                            })
      return { stripe_charge: stripe_charge, error: nil }
    rescue Stripe::StripeError => e
      return { stripe_charge: stripe_charge, error: e }
    end
  end
end
