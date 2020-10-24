class BillingsController < ApplicationController
  before_action :set_address, only: [:new, :create]
  before_action :set_product, only: [:new, :create]


  def new
    @subscription = Subscription.find(params[:subscription_id])
    @billing = Billing.new
  end

  def create
    @subscription = Subscription.find(params[:billing][:subscription_id])
    @billing = Billing.new(billing_params)
    if @billing.save
      @subscription.update(billing_id: @billing.id)
    else
      flash[:alert] = 'Error'
      redirect_to new_address_product_billing_path(@address, @product)
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
    params.require(:billing).permit(:address, :first_name, :last_name, :bic, :iban)
  end
end
