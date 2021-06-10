class PickupsController < ApplicationController
  before_action :redirect_if_order_is_paid, only: [:new]

  def new
    @order = Order.find(params[:order_id])
    @pickup = @order.pickup || Pickup.new
    @message = { content: "Alright, almost done! I just need your flight details to arrange your airport pickup. ", delay: 0 }
  end
end
