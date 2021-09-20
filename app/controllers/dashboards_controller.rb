class DashboardsController < ApplicationController

  def index
    return redirect_to checkout_path(current_user.orders.select{|o| o.state == 'pending_payment'}[0]) if current_user.pending_orders?
    orders = current_user.orders.includes([:products], [:items], [:user], [:shipping], [:subscription])
    @order = current_user.orders.filter{|o| o&.subscription&.state == 'active'}[0]
    return redirect_to dashboard_orders_path if @order.nil?
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
