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
        subscription = response[:subscription].items.data.filter{|a| a.plan.id == plan.stripe_id}[0]
        subscription_item_id = subscription.id if subscription
        delete_subscription_item(subscription_item_id) if subscription_item_id
        delete_service_from_subscription
      else
        delete_service_from_subscription
      end
    else
      delete_service_from_subscription
    end
  end

  def delete_service_from_subscription
    subscription = Subscription.find(@subscription_id)
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
