class DashboardsController < ApplicationController

  def index
    pending_order = current_user.orders.select{|o| o.state == 'pending_payment'}[0]
    return redirect_to new_cart_path("settle_in") if current_user.pending_orders? && pending_order.subscription.nil?
    return redirect_to checkout_path(pending_order) if current_user.pending_orders?
    orders = current_user.orders.includes([:products], [:items], [:user], [:shipping], [:subscription])
    @order = current_user.orders.filter{|o| o&.subscription&.state == 'active'}[0]
    if @order.nil?
      flash[:alert] = 'You need an active subscription to access dashboard'
      return redirect_to dashboard_orders_path
    end
    @inactive_products = Product.where.not(id: @order.products.pluck(:id)).filter{|p| p.pack.name == 'settle_in' && p.country == current_user.house.country}
  end


  def plan
    @plan = Plan.find(params[:plan_id])
    @order = current_user.orders.filter{|o| o&.subscription&.state == 'active'}[0]
  end

  def orders
    @order = current_user.orders.detect {|o| o.pack == 'starter'}
  end

  def cancel_plan
    response = StripeApiBillingService.new(plan_id: params[:plan_id]).update_subscription_plan
    if response
      flash[:success] = 'Plan was succesfully cancelled.'
    else
      flash[:alert] = 'Something went wrong, please try again later.'
    end
    redirect_to dashboard_path
  end

end
