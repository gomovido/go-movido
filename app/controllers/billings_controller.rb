class BillingsController < ApplicationController

  def create
    @subscription = Subscription.find(params[:billing][:subscription_attributes][:id])
    @billing = Billing.new(user_id: current_user.id)
    @billing.subscription = @subscription
    if @billing.update(billing_params)
      @subscription.update(billing_id: @billing.id)
      redirect_to subscription_summary_path(params[:billing][:subscription_attributes][:id])
    else
      @last_billing = current_user.billings.last
      render 'new'
    end
  end
end
