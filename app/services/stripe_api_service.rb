class StripeApiService
  def initialize(params)
    @stripe_token = params[:stripe_token]
    @subscription_id = params[:subscription_id]
  end

  def create_charge
    subscription = Subscription.find(@subscription_id)
    begin
      stripe_charge = Stripe::Charge.create({
          amount: subscription.product.sim_card_price_cents,
          currency: subscription.product.currency,
          source: @stripe_token,
          description: "Subscription ##{subscription.id}",
        })
      hash = {stripe_charge: stripe_charge, error: nil}
      return hash
    rescue Stripe::CardError => e
      hash = {stripe_charge: stripe_charge, error: e}
      return hash
    end
  end

end
