class ShippingReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    @order = Order.find(params[:order_id])
    @shipping = @order.shipping || Shipping.new
    @shipping.assign_attributes(shipping_params)
    @shipping.state = 'initiated'
    if @shipping.save
      @order.update(shipping: @shipping)
      if current_user.user_preference.pickup?
        morph '.flow-container', render(partial: "steps/pickup/pickup", locals: { order: @order, pickup: @order.pickup || Pickup.new, messages: [{ content: "Alright, almost done! I just need your flight details to arrange your airport pickup. ", delay: 0 }] })
      else
        morph '.flow-container', render(partial: "steps/checkout/checkout", locals: { order: @order, billing: (@order.billing || Billing.new), messages: [{ content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }] })
      end
    else
      morph '.form-base', render(partial: "steps/shipping/shipping_form", locals: { shipping: @shipping, order: @order })
    end
  end

  private

  def shipping_params
    params.require(:shipping).permit(:address, :instructions)
  end
end
