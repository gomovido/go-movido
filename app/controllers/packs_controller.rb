class PacksController < ApplicationController
  def index
    @message = { content: "Amazing! Please wait a few seconds as I put together your customized pack.", delay: 0 }
    @order = Order.find_by(user: current_user, id: params[:order_id])
  end
end
