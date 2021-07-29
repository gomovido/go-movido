class SubscriptionsController < ApplicationController
  def new
    @order = Order.find_by(id: params[:order_id], user: current_user)
    if @order
      @subscription = @order.subscription || Subscription.new
      @message = { content: "This is legals stuff", delay: 0 }
    else
      flash[:alert] = "You can't access this order."
      redirect_to root_path
    end
  end
end
