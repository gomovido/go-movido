class DashboardsController < ApplicationController

  def index
    redirect_to root_path if Order.where(user: current_user, state: 'succeeded').blank? && Order.where(user: current_user, state: 'pending_payment').blank? && Order.where(user: current_user, state: 'cancelled').blank?
    orders = current_user.orders.includes([:products], [:items], [:user], [:shipping], [:subscription])
    @subscriptions = []
    @ongoing_invoice = nil
    @products = []
    @order = current_user.orders.filter{|o| o&.subscription&.state == 'active'}[0]
    @inactive_products = Product.where.not(id: @order.products.pluck(:id)).filter{|p| p.pack.name == 'settle_in' && p.country == current_user.house.country}
  end


  def plan
    @plan = Plan.find(params[:plan_id])
    @order = current_user.orders.filter{|o| o&.subscription&.state == 'active'}[0]
  end

  def orders
    @order = current_user.orders.detect {|o| o.pack == 'starter'}
  end

end
