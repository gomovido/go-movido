class PaymentsController < ApplicationController
  def new
    @order = Order.find_by(id: params[:order_id], user: current_user)
    redirect_to congratulations_path(@order) if @order.paid?
  end

  def create
    stripe_token = params[:stripeToken]
    order = Order.find(params[:order_id])
    response = StripeApiChargeService.new(stripe_token: stripe_token, order_id: order.id).proceed_payment
    if response[:error].nil? && response[:stripe_charge]
      charge = Charge.create(state: response[:stripe_charge].status, stripe_charge_id: response[:stripe_charge].id)
      order.update(state: 'succeeded', charge: charge)
      flash[:notice] = 'Payment success!'
      redirect_to congratulations_path(order.id)
    else
      order.update(state: 'payment_failed')
      flash[:alert] = response[:error]
      redirect_back(fallback_location: root_path)
    end
  end
end
