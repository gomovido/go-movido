class PickupsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @pickup = @order.pickup || Pickup.new
    @messages = [{ content: "Alright, almost done! I just need your flight details to arrange your airport pickup. ", delay: 0 }]
  end
end
