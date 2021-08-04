class SubscriptionReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    @order = Order.find_by(id: subscription_params[:order_id], user: current_user)
    @subscription = @order.subscription || Subscription.new
    if terms_not_checked?(subscription_params[:terms])
      @subscription.errors.add(:terms, 'You need to accept the Terms and Conditions of movido')
      morph '.form-base', render(partial: "steps/subscription/form", locals: { order: @order, subscription: @subscription, message: { content: "This is legals stuff", delay: 0 } })
    elsif terms_not_checked?(subscription_params[:terms_provider])
      @subscription.errors.add(:terms_provider, 'You need to accept the Terms and Conditions of providers')
      morph '.form-base', render(partial: "steps/subscription/form", locals: { order: @order, subscription: @subscription, message: { content: "This is legals stuff", delay: 0 } })
    else
      @subscription = init_subscription(@order)
      UserMailer.with(user_id: @order.user, order_id: @order.id, locale: 'en').contract_agreed.perform_later
      cable_ready.push_state(cancel: false, url: Rails.application.routes.url_helpers.checkout_path(@order))
      morph '.flow-container', render(partial: "steps/checkout/new", locals: { order: @order, billing: (@order.billing || Billing.new), subscription: @subscription, message: { content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 } })
    end
  end

  def init_subscription(order)
    Subscription.create(
      order: order,
      subscription_price_cents: order.total_subscription_amount,
      activation_price_cents: order.total_activation_amount,
      starting_date: current_user.house.house_detail.contract_starting_date,
      state: "active"
    )
  end

  def terms_not_checked?(terms)
    terms == '0'
  end

  private

  def subscription_params
    params.require(:subscription).permit(:terms, :terms_provider, :order_id)
  end
end
