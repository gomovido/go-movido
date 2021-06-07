class PaymentsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
  end

  def create
    response = StripeApiChargeService.new(stripe_token: params[:stripe_token], order_id: params[:order_id]).proceed_payment
    if response[:error].nil? && response[:stripe_charge]
      raise
      charge = Charge.create(state: response[:stripe_charge].status, stripe_charge_id: response[:stripe_charge].id)
      Order.find(params[:order_id]).update(state: 'succedeed', charge: charge)
      flas[:notice] = 'Payment success!'
      redirect_to congratulations_path
    else
      flash[:alert] = response[:error]
      redirect_back(fallback_location: root_path)
    end
  end
end
