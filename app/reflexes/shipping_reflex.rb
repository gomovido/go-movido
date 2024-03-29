class ShippingReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex do
    @order = Order.find_by(id: params[:order_id], user: current_user)

    morph_if_paid(@order.id)
  end

  def create
    return if @order.paid?

    @pack = @order.pack
    @shipping = @order.shipping || Shipping.new
    @shipping.assign_attributes(shipping_params)
    @shipping.state = 'initiated'
    if @shipping.save && @order.update(shipping: @shipping)
      morph_to_next_step
    else
      morph '.form-base', render(partial: "steps/shipping/form", locals: { shipping: @shipping, order: @order, pack: @pack })
    end
  end

  def morph_to_next_step
    if current_user.house.pickup?
      cable_ready.push_state(cancel: false, url: Rails.application.routes.url_helpers.new_pickup_path(@order))
      morph '.flow-container', render(partial: "steps/pickup/new", locals: { order: @order, pickup: @order.pickup || Pickup.new, message: { content: "Alright, almost done! I just need your flight details to arrange your airport pickup. ", delay: 0 } })
    else
      cable_ready.push_state(cancel: false, url: Rails.application.routes.url_helpers.checkout_path(@order))
      morph '.flow-container', render(partial: "steps/checkout/new", locals: { order: @order, billing: (@order.billing || Billing.new), message: { content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 } })
    end
  end

  private

  def shipping_params
    params.require(:shipping).permit(:address, :instructions)
  end
end
