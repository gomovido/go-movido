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


  def cancel
    subscription = Order.find_by(id: params[:order_id], user: current_user).subscription
    if subscription
      response = StripeApiBillingService.new(subscription_id: subscription.id).cancel_subscription
      if response[:error].nil?
        flash[:notice] = "Your subscription is now cancelled."
      else
        flash[:alert] = "An error has occured please contact us or try again later."
      end
    else
      flash[:alert] = "An error has occured please contact us or try again later."
    end
    redirect_to dashboard_path
  end
end
