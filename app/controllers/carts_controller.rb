class CartsController < ApplicationController
  def new
    @house = current_user.house
    @order = current_user.current_draft_order || Order.new
    @message = { content: "Almost done! Please select the services you need to get started in your new city", delay: 0 }
  end

  def show
    @cart = Order.find_by(id: params[:order_id], user: current_user).cart
  end
end
