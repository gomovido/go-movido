class StripeApiChargeService
  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
    @customer_id = params[:customer_id]
  end

  def create
    order = Order.find(@order_id)
    amount = order.affiliate_link.present? ? order.discounted_activation_amount(20) : order.total_activation_amount
    begin
      stripe_charge = Stripe::Charge.create({
                                              amount: amount,
                                              currency: order.currency,
                                              customer: @customer_id,
                                              description: "This is payment for user #{order.user.email} - Order #-#{order.id}"
                                            })
      return { stripe_charge: stripe_charge, error: nil }
    rescue Stripe::StripeError => e
      return { stripe_charge: stripe_charge, error: e }
    end
  end
end
