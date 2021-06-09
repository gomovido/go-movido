class StepsController < ApplicationController
  def simplicity
    @user_preference = current_user.user_preference || UserPreference.new
    @messages = [{ content: "Great, #{current_user.first_name}! First of all, tell me more about your move ", delay: 0 }]
  end

  def conversion
    @order = Order.find(params[:order_id])
    @shipping = @order.shipping || Shipping.new
    @messages = [{ content: "Now please enter your current home address details for the shipment of your Starter Pack", delay: 0 }]
    redirect_to congratulations_path(@order) if @order.paid?
  end

  def payment
    @order = Order.find_by(id: params[:order_id], user: current_user)
    @billing = @order.billing || Billing.new
    @messages = [{ content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }]
    redirect_to congratulations_path(@order) if @order.paid?
  end
end
