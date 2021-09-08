class DashboardReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def payment_details(arg)
    @cards = arg['sources']['data']
    @default_source = arg['default_source']
    morph '.cards-wrapper', render(partial: "payment_details/cards", locals: { cards: @cards, default_source: @default_source } )
  end

  def subscriptions(arg)
    @subscriptions = arg['data']
    @ongoing_subscription = @subscriptions[0]
    @order = current_user.orders.filter{|o| o.subscription.state == 'active'}[0]
    morph '.subscriptions-wrapper', render(partial: "dashboards/index/subscriptions", locals: { subscriptions: @subscriptions, ongoing_subscription: @ongoing_subscription, order: @order } )
  end
end
