class Forest::SubscriptionsController < ForestLiana::SmartActionsController
  def activate_subscription
    subscription_id = ForestLiana::ResourcesGetter.get_ids_from_request(params).first
    subscription = Subscription.find(subscription_id)
    UserMailer.with(user: subscription.address.user, subscription: subscription, locale: subscription.locale).subscription_confirmed_email.deliver_now if subscription.update(state: 'activated')
    head :no_content
  end
end
