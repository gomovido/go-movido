class OrdersController < ApplicationController
  def create
    order = Order.find_by(user: current_user, state: 'pending_payment')
    current_user.user_preference.carts.last.items.update_all(order_id: order.id)
    redirect_to new_shipping_path(order.id)
  end

  def congratulations
    @order = Order.find_by(user: current_user, id: params[:order_id])
  end
end
