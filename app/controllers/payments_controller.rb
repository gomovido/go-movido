class PaymentsController < ApplicationController
  before_action :redirect_if_order_is_paid, only: [:new]
  before_action :set_order, only: %i[new create initialize_billing]

  def new
    redirect_to new_shipping_path(@order.id) and return unless @order.ready_to_checkout?

    @billing = @order.billing || Billing.new
    @message = { content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }
  end

  def create
    redirect_to dashboard_path and return if @order.paid?

    @billing = initialize_billing
    if @billing.save
      proceed_payment(params[:stripeToken], @order)
    else
      @message = { content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }
      render :new
    end
  end

  def initialize_billing
    billing = @order.billing || Billing.new
    billing.assign_attributes(billing_params)
    billing.order = @order
    return billing
  end

  def proceed_payment(stripe_token, order)
    response = StripeApiChargeService.new(stripe_token: stripe_token, order_id: order.id).proceed_payment
    charge = order.charge || Charge.new
    if response[:error].nil? && response[:stripe_charge]
      charge.update(state: response[:stripe_charge].status, stripe_charge_id: response[:stripe_charge].id)
      order.update(state: 'succeeded', charge: charge, billing: @billing)
      UserMailer.with(user: current_user, locale: 'en').order_confirmed.deliver_later
      flash[:notice] = 'Payment success!'
      redirect_to congratulations_path(order.id)
    else
      charge.update(state: 'payment_failed')
      order.update(charge: charge, billing: @billing)
      @message = { content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }
      flash[:alert] = "Payment failed"
      render :new
    end
  end

  def billing_params
    params.require(:billing).permit(:address)
  end

  def set_order
    @order = Order.find_by(id: params[:order_id], user: current_user)
  end
end
