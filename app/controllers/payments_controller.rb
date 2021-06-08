class PaymentsController < ApplicationController
  def new
    @order = Order.find_by(id: params[:order_id], user: current_user)
    @messages = [{ content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }]
    redirect_to congratulations_path(@order) if @order.paid?
  end

  def create
    @order = Order.find(params[:order_id])
    if billing_params['address'].present?
      billing = create_billing(@order.id)
      stripe_token = params[:stripeToken]
      response = StripeApiChargeService.new(stripe_token: stripe_token, order_id: @order.id).proceed_payment
      if response[:error].nil? && response[:stripe_charge]
        charge = Charge.create(state: response[:stripe_charge].status, stripe_charge_id: response[:stripe_charge].id)
        @order.update(state: 'succeeded', charge: charge, billing: billing)
        p 'THIS IS BILLING'
        p @order.billing
        flash[:notice] = 'Payment success!'
        redirect_to congratulations_path(@order.id)
      else
        @order.update(state: 'payment_failed')
        @messages = [{ content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }]
        render :new
      end
    else
      @order.errors.add(:address, "Billing address is required")
      @messages = [{ content: "Thanks #{current_user.first_name}, now please enter your payment details to finalize the order of your Starter Pack", delay: 0 }]
      render :new
    end
  end

  def create_billing(order_id)
    order = Order.find(order_id)
    billing = order.billing || Billing.new
    billing.assign_attributes(billing_params)
    billing.order = order
    billing.save
    billing
  end

  def billing_params
    params.require(:billing).permit(:address)
  end
end
