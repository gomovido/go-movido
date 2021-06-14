class PacksController < ApplicationController
  def index
    @message = { content: "Thanks for waiting, please find your customized Starter Pack below.", delay: 0 }
    @order = Order.find_by(user: current_user, id: params[:order_id])
  end
end
