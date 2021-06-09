class ShippingsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @shipping = @order.shipping || Shipping.new
    @messages = [{ content: "Now please enter your current home address details for the shipment of your Starter Pack", delay: 0 }]
  end
end
