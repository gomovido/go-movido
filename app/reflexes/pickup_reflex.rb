class PickupReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    order = Order.find(params[:order_id])
    @pickup = order.pickup || Pickup.new
    @pickup.uncomplete = pickup_params[:uncomplete]
    @pickup.assign_attributes(pickup_params) if @pickup.complete?
    @pickup.order = order
    if @pickup.save
      morph '.flow-container', render(partial: "steps/checkout/checkout", locals: { order: order, billing: (order.billing || Billing.new), messages: [{ content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }] })
    else
      morph '.form-base', render(partial: "steps/pickup/pickup_form", locals: { pickup: @pickup, order: order })
    end
  end

  private

  def pickup_params
    params.require(:pickup).permit(:arrival, :airport, :uncomplete, :flight_number)
  end
end
