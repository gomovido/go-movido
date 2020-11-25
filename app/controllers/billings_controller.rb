class BillingsController < ApplicationController
  before_action :set_subscription, only: [:new, :new_uk, :new_fr, :create]

  def new
    @billing = Billing.new
    @billing.build_subscription if @subscription.product.category.name == 'mobile'
    redirect_to_new(@subscription)
  end

  def new_uk
  end

  def new_europe
  end

  def create
    @billing = Billing.new
    @billing.subscription = @subscription
    @billing.user = current_user
    @billing.iban = sanitized_iban
    @billing.bic = sanitized_bic
    @billing.update(billing_params)
    if @billing.save
      if @subscription.product.sim_card_price.cents >= 1
        redirect_to subscription_payment_path(@subscription)
      else
        redirect_to subscription_summary_path(@billing.subscription)
      end
    else
      redirect_to_new(@subscription)
    end
  end


  def redirect_to_new(subscription)
    subscription.product.country == 'United Kingdom' ? (render :new_uk) : (render :new_europe)
  end

  private

  def sanitized_bic
    billing_params[:bic].upcase
  end

  def sanitized_iban
    billing_params[:iban].upcase.gsub(" ","")
  end

  def billing_params
    params.require(:billing).permit(:address, :bic, :iban, :bank, :holder_name, :account_number, :sort_code, :subscription_id, subscription_attributes: [:id, :delivery_address, :sim])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end
end
