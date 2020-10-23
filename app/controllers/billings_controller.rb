class BillingsController < ApplicationController
  before_action :set_address, only: [:new, :create]
  before_action :set_product, only: [:new, :create]

  def new
    @subscription = Subscription.all.where(product: @product, address: @address, state: 'draft').first
    @billing = Billing.new
  end

  def create
    @billing = Billing.new(billing_params)
    @subscription = Subscription.all.where(product: @product, address: @address, state: 'draft').first
    if @billing.save
      @subscription.update(billing_id: @billing.id)
    else
      redirect_to new_address_product_billing_path(@address, @product)
      flash[:alert] = 'Error'
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
