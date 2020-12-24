class BillingsController < ApplicationController
  before_action :set_subscription, only: [:new, :new_uk, :new_fr, :create]

  def new
    if !current_user.is_complete?
      redirect_to subscription_complete_profil_path(@subscription)
    else
      @billing = Billing.new
      @billing.build_subscription if @subscription.product.is_mobile?
      redirect_to_new(@subscription)
    end
  end

  def new_uk; end

  def new_europe; end

  def create
    @billing = Billing.new
    @billing.subscription = @subscription
    @billing.user = current_user
    @billing.update(billing_params)
    @billing.iban = sanitized_iban
    @billing.bic = sanitized_bic
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

  def sanitized_bic
    billing_params[:bic].upcase if billing_params[:bic].present?
  end

  def sanitized_iban
    billing_params[:iban].upcase.gsub(" ","") if billing_params[:iban].present?
  end

  def billing_params
    params.require(:billing).permit(:address, :bic, :iban, :bank, :holder_name, :account_number, :sort_code, :subscription_id, subscription_attributes: [:id, :delivery_address, :sim])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end
end
