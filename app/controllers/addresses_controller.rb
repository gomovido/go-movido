class AddressesController < ApplicationController

  before_action :set_subscription, only: [:update_subscription_address, :update]

  def update_subscription_address
    @subscription = Subscription.find(params[:subscription_id])
  end


  def update
    if @subscription.update(subscription_params)
      redirect_to new_subscription_billing_path(@subscription)
    else
      render :update_subscription_address
    end
  end


  private


  def subscription_params
    params.require(:subscription).permit(:delivery_address, :sim, billing_attributes: [:address, :bic, :iban, :bank, :user_id], address_attributes: [:id, :floor, :street, :building, :stairs, :door, :gate_code])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end



end
