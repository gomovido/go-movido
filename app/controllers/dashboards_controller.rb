class DashboardsController < ApplicationController

  def index
    redirect_to root_path if Order.where(user: current_user, state: 'succeeded').blank? && Order.where(user: current_user, state: 'pending_payment').blank? && Order.where(user: current_user, state: 'cancelled').blank?
    orders = current_user.orders.includes([:products], [:items], [:user], [:shipping], [:subscription])
    @products = []
    @live_orders = orders.reject { |o| (o.pack == 'settle_in' and o.subscription.nil?) || o.items.blank? }
    @pending_orders = orders.filter { |o| o.subscription.nil? }
  end

  def new_dashboard
    @orders = Order.where(user: current_user)
    @starter_order = @orders.detect {|o| o.pack == 'starter'}
    @settle_in_order = @orders.detect {|o| o.pack == 'settle_in'}
  end

end
