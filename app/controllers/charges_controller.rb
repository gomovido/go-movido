class ChargesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]
  before_action :set_subscription, only: [ :create ]

  def create
    stripe_token = params[:stripeToken]
    process_payment(@subscription, stripe_token)
  end


  def process_payment(subscription, stripe_token)
    begin
      stripe_charge = Stripe::Charge.create({
          amount: subscription.product.sim_card_price_cents,
          currency: subscription.product.sim_card_price_currency,
          source: stripe_token,
          description: "Subscription ##{subscription.id}",
        })
      charge = create_charge(stripe_charge, subscription)
      subscription.update(state: 'succeeded') if charge.status == 'succeeded'
      UserMailer.with(user: subscription.address.user, subscription: subscription).congratulations.deliver_now
      redirect_to subscription_congratulations_path(subscription)
    rescue Stripe::CardError => e
      flash[:alert] = e
      redirect_back(fallback_location: root_path)
    end
  end


  def create_charge(stripe_charge, subscription)
    charge = Charge.create(
      stripe_charge_id: stripe_charge.id,
      status: stripe_charge.status,
      subscription_id: subscription.id,
    )
    return charge
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:subscription][:subscription_id])
  end
end
