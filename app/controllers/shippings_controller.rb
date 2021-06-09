class ShippingsController < ApplicationController
  before_action :redirect_if_order_is_paid, only: [:new]

  def new
    @order = Order.find(params[:order_id])
    @shipping = @order.shipping || Shipping.new
    @messages = [{ content: "Now please enter your current home address details for the shipment of your Starter Pack", delay: 0 }]
  end
end
