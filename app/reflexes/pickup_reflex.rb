class PickupReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex do
    @order = current_user.current_draft_order('starter')
    morph_if_paid(@order.id)
  end

  def create
    return if @order.paid?

    @pickup = @order.pickup || Pickup.new
    @pickup.uncomplete = pickup_params[:uncomplete]
    @pickup.assign_attributes(pickup_params) if @pickup.complete?
    @pickup.order = @order
    if @pickup.save
      morph '.flow-container', render(partial: "steps/checkout/new", locals: { order: @order, billing: (@order.billing || Billing.new), message: { content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 } })
    else
      morph '.form-base', render(partial: "steps/pickup/form", locals: { pickup: @pickup, order: @order })
    end
  end

  private

  def pickup_params
    params.require(:pickup).permit(:arrival, :airport, :uncomplete, :flight_number)
  end
end
