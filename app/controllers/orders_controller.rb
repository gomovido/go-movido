class OrdersController < ApplicationController
  def create
    order = Order.create(user: current_user, state: 'pending_payment')
    current_user.user_preference.cart.items.update_all(order_id: order.id)
    redirect_to conversion_path(order)
  end
end
