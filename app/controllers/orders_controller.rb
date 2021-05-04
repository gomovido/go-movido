class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def new
    @subscription = Subscription.find(params[:subscription_id])
  end

  def create
    @subscription = Subscription.find(params[:subscription][:subscription_id])
    stripe_token = params[:stripeToken]
    response = StripeApiOrderService.new(user_id: current_user.id, subscription_id: @subscription.id).init_order
    if response[:stripe_order]
      order = Order.where(stripe_id: response[:stripe_order].id, status: 'initiated', subscription: @subscription).first_or_create
      process_payment(order, @subscription, stripe_token)
    else
      flash[:alert] = 'An error has occured'
      redirect_back(fallback_location: root_path, locale: I18n.locale)
    end

  end

  def process_payment(order, subscription, stripe_token)
    response = StripeApiOrderService.new(stripe_token: stripe_token, stripe_order_id: order.stripe_id).proceed_payment
    I18n.locale = params[:subscription][:locale].to_sym
    if payment_is_succeeded?(response)
      order.update(status: 'paid')
      subscription.update_columns(state: 'succeeded', locale: I18n.locale, password: @subscription.random_password)
      UserMailer.with(user: subscription.address.user, subscription: subscription, locale: I18n.locale).subscription_under_review_email.deliver_now
      subscription.slack_notification
      redirect_to subscription_congratulations_path(subscription, locale: I18n.locale)
    else
      subscription.update_columns(state: 'payment_failed', locale: I18n.locale)
      order.update(status: 'payment_failed')
      flash[:alert] = I18n.t("stripe.errors.#{response[:error].code}")
      redirect_back(fallback_location: root_path, locale: I18n.locale)
    end
  end

  def payment_is_succeeded?(response)
    response[:stripe_order].status == 'paid' if response[:stripe_order]
  end

end
