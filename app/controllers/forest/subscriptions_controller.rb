# rubocop:disable Style/ClassAndModuleChildren
class Forest::SubscriptionsController < ForestLiana::SmartActionsController
  # rubocop:enable Style/ClassAndModuleChildren
  def activate_subscription
    subscription_ids = ForestLiana::ResourcesGetter.get_ids_from_request(params)
    subscription_ids.each do |subscription_id|
      subscription = Subscription.find(subscription_id.to_i)
      if subscription.update_columns(state: 'activated')
        UserMailer.with(user: subscription.address.user, subscription: subscription,
                        locale: subscription.locale).subscription_confirmed_email.deliver_now
      end
    end
    segment_id = Rails.env.production? ? "d0162d10-7dbc-11eb-b3b2-a167c4ce3013" : "700b57c0-7dbb-11eb-8e18-216c8c60cc7e"
    render json: {
      success: 'Subscription successfully activated',
      redirectTo: "/go-movido-admin/#{Rails.env.capitalize}/Movido/data/Subscription/index?segmentId=#{segment_id}"
    }
  end
end
