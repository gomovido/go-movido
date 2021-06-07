class OrdersController < ApplicationController
  def new
  end

  def congratulations
    @order = Order.find_by(user: current_user, id: params[:order_id])
  end
end
