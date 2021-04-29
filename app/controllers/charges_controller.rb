class ChargesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

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
    stripe_charge = StripeApiService.new(subscription_id: subscription.id, stripe_token: stripe_token, user_id: current_user.id).proceed_stripe
    I18n.locale = params[:subscription][:locale].to_sym
    if payment_is_succeeded?(stripe_charge)
      create_or_update_charge(stripe_charge, subscription)
      subscription.update_columns(state: 'succeeded', locale: I18n.locale, password: @subscription.random_password)
      UserMailer.with(user: subscription.address.user, subscription: subscription, locale: I18n.locale).subscription_under_review_email.deliver_now
      subscription.slack_notification
      redirect_to subscription_congratulations_path(subscription, locale: I18n.locale)
    else
      subscription.update_columns(state: 'payment_failed', locale: I18n.locale)
      flash[:alert] = I18n.t("stripe.errors.#{stripe_charge[:error].code}")
      redirect_back(fallback_location: root_path, locale: I18n.locale)
    end
  end

  def payment_is_succeeded?(stripe_charge)
    stripe_charge[:stripe_charge].status == 'succeeded' if stripe_charge[:stripe_charge]
  end

  def create_or_update_charge(stripe_charge, subscription)
    charge = Charge.where(subscription: subscription).first_or_create
    charge.update(stripe_charge_id: stripe_charge[:stripe_charge].id, status: stripe_charge[:stripe_charge].status)
    return charge
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end
end
