class StripeApiBillingService
  def initialize(params)
    @order_id = params[:order_id]
    @stripe_token = params[:stripe_token]
    @subscription_id = params[:subscription_id]
    @plan_id = params[:plan_id]
  end

  def update_subscription_plan
    plan = Plan.find(@plan_id)
    if plan.stripe_id
      response = StripeApiSubscriptionService.new(subscription_stripe_id: plan.subscription.stripe_id).retrieve
      if response[:subscription]
        subscription_items = response[:subscription].items.data.filter{|a| a.plan.id == plan.stripe_id}
        subscription = subscription_items[0]
        subscription_item_id = subscription.id if subscription
        if subscription_items.length >= 1
          delete_subscription_item(subscription_item_id) if subscription_item_id
        else
          delete_subscription(response[:subscription].id)
        end
      else
        delete_service_from_subscription
      end
    else
      delete_service_from_subscription
    end
  end

  def delete_subscription(subscription_stripe_id)
    subscription = Subscription.find(stripe_id: subscription_stripe_id)
    begin
      subscription = Stripe::Subscription.delete(subscription_stripe_id)
      subscription.update(state: 'cancelled')
      {subscription: subscription, error: nil}
    rescue  Stripe::StripeError => e
      {subscription: nil, error: e}
    end
  end

  def delete_service_from_subscription
    plan = Plan.find(@plan_id)
    plan.product.items.select{|i| i.cart == plan.subscription.order.cart }[0].destroy
  end

  def delete_subscription_item(subscription_item_id)
    begin
      subscription_item = Stripe::SubscriptionItem.delete( subscription_item_id )
      { subscription_item: subscription_item, error: nil }
    rescue Stripe::StripeError => e
      { subscription_item: nil, error: e }
    end
  end

  def update_customer(stripe_id)
    begin
      customer = Stripe::Customer.update(
        stripe_id,
        source: @stripe_token
      )
      { customer: customer, error: nil }
    rescue Stripe::StripeError => e
      { customer: nil, error: e }
    end
  end

end
