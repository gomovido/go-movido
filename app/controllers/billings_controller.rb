class BillingsController < ApplicationController
  before_action :set_address, only: [:new, :create]
  before_action :set_product, only: [:new, :create]


  def new
    @subscription = Subscription.find(params[:subscription_id])
    @billing = Billing.new
    @last_billing = current_user.billings.last
    @billing.build_subscription
  end

  def create
    @subscription = Subscription.find(params[:billing][:subscription_attributes][:id])
    @billing = Billing.new(user_id: current_user.id)
    @billing.subscription = @subscription
    if @billing.update(billing_params)
      @subscription.update(billing_id: @billing.id)
      redirect_to subscription_summary_path(params[:billing][:subscription_attributes][:id])
    else
      flash[:alert] = 'All fields are required'
      redirect_to new_address_product_billing_path(@address, @product, subscription_id: @subscription.id)
    end
  end

  private

  def set_address
    @address = Address.find(params[:address_id])
  end

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def billing_params
    params.require(:billing).permit(:address, :first_name, :last_name, :bic, :iban, subscription_attributes: [:start_date, :id])
  end
end
