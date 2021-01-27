class BillingsController < ApplicationController
  before_action :set_subscription, only: [:new, :create, :update]

  def new
    if !current_user.is_complete?
      redirect_to subscription_complete_profil_path(@subscription)
    else
      @billing = @subscription.billing.nil? ? Billing.new : @subscription.billing
      @billing.build_subscription(delivery_address: @subscription.delivery_address) if @subscription.product.is_mobile?
      render :new
    end
  end

  def create
    @billing = Billing.new
    @billing.user = current_user
    @billing.subscription = @subscription
    @billing.update(billing_params)
    if @billing.save
      redirect_to subscription_summary_path(@billing.subscription)
    else
      render :new
    end
  end

  def update
    @billing = @subscription.billing
    if @billing.update(billing_params)
      redirect_to subscription_summary_path(@billing.subscription)
    else
      render :new
    end
  end

  private

  def billing_params
    params.require(:billing).permit(:address, :iban, :holder_name, :subscription_id, subscription_attributes: [:id, :delivery_address, :sim])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end
end
