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
    subscription.update(state: 'paid')
    create_charge(stripe_charge, subscription)
    UserMailer.with(user: subscription.address.user, subscription: subscription).congratulations.deliver_now
    redirect_to subscription_congratulations_path(subscription)
    rescue Stripe::CardError => e
      flash[:alert] = e
      redirect_back(fallback_location: root_path)
    end
  end


  def create_charge(stripe_charge, subscription)
    Charge.create(
      stripe_charge_id: stripe_charge.id,
      status: stripe_charge.status,
      subscription_id: subscription.id,
    )
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end
end
