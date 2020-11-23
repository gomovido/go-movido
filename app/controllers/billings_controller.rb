class BillingsController < ApplicationController
  before_action :set_subscription, only: [:new, :new_uk, :new_fr, :create]

  def new
    @billing = Billing.new
    redirect_to_new(@subscription)
  end

  def new_uk
  end

  def new_europe
  end

  def create
    @billing = Billing.new(billing_params)
    @billing.subscription = @subscription
    @billing.user = current_user
    if @billing.save
      redirect_to subscription_summary_path(@billing.subscription)
    else
      redirect_to_new(@subscription)
    end
  end


  def redirect_to_new(subscription)
    subscription.product.country == 'United Kingdom' ? (render :new_uk) : (render :new_europe)
  end

  private


  def billing_params
    params.require(:billing).permit(:address, :bic, :iban, :bank, :holder_name, :account_number, :sort_code, :subscription_id)
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end
end
