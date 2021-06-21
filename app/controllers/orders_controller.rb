class OrdersController < ApplicationController
  def congratulations
    @order = Order.find_by(user: current_user, id: params[:order_id])
    @message = { content: "Congratulations #{current_user.first_name}! Your movido Starter Pack is already on its way to you 🎉 ", delay: 0 }
  end
end
