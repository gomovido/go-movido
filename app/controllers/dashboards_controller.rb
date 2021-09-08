class DashboardsController < ApplicationController

  def index
    redirect_to root_path if Order.where(user: current_user, state: 'succeeded').blank? && Order.where(user: current_user, state: 'pending_payment').blank? && Order.where(user: current_user, state: 'cancelled').blank?
    orders = current_user.orders.includes([:products], [:items], [:user], [:shipping], [:subscription])
    @subscriptions = []
    @ongoing_invoice = nil
    @products = []
    @order = current_user.orders.filter{|o| o.subscription.state == 'active'}[0]
  end


  def plan
    @plan = Plan.find(params[:plan_id])
  end

end
