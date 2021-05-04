class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]


  def new
    init_order(params[:subscription_id])
  end


  def init_order(subscription_id)
    StripeApiOrderService.new(user_id: current_user.id, subscription_id: subscription_id).init_order
  end

end
