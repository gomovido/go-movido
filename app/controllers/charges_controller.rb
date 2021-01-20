class ChargesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    @subscription = Subscription.find(params[:subscription][:subscription_id])
    stripe_token = params[:stripeToken]
    process_payment(@subscription, stripe_token)
  end

  def new
    @subscription = Subscription.find(params[:subscription_id])
    @charge = Charge.new
    redirect_to subscription_congratulations_path(@subscription) if @subscription.state == 'succeeded'
  end

  def process_payment(subscription, stripe_token)
    begin
      stripe_charge = Stripe::Charge.create({
          amount: subscription.product.sim_card_price_cents,
          currency: subscription.product.currency,
          source: stripe_token,
          description: "Subscription ##{subscription.id}",
        })
      charge = create_charge(stripe_charge, subscription)
      subscription.update(state: 'succeeded') if charge.status == 'succeeded'
      UserMailer.with(user: subscription.address.user, subscription: subscription).subscription_under_review_email.deliver_now
      redirect_to subscription_congratulations_path(subscription)
    rescue Stripe::CardError => e
      p "STRIPE ERROR"
      p e
      subscription.update(state: 'payment_failed')
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
    @subscription = Subscription.find(params[:subscription_id])
  end
end
