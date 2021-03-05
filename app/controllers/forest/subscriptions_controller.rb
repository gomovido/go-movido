class Forest::SubscriptionsController < ForestLiana::SmartActionsController
  def activate_subscription
    subscription_ids = ForestLiana::ResourcesGetter.get_ids_from_request(params)
    subscription_ids.each do |subscription_id|
      subscription = Subscription.find(subscription_id.to_i)
      UserMailer.with(user: subscription.address.user, subscription: subscription, locale: subscription.locale).subscription_confirmed_email.deliver_now if subscription.update_columns(state: 'activated')
    end
    head :no_content
  end
end
