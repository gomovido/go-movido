class CartsController < ApplicationController
  def new
    @user_preference = current_user.user_preference
    @message = { content: "Almost done! Please select the services you need - you can pick and choose across packs if you like", delay: 0 }
  end

  def show
    @cart = Order.find_by(id: params[:order_id], user: current_user).cart
  end
end
