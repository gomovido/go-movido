class SubscriptionsController < ApplicationController

  before_action :set_product, only: [:new, :create, :update]
  before_action :manage_address, only: [:new, :create]

  def create
    @address = Address.find(params[:address_id])
    subscription = Subscription.new(product: @product, address: @address, state: 'draft')
    if Subscription.all.where(product: @product, address: @address, state: 'draft').length > 1
      flash[:alert] = "You already have a pending subscription for #{@product} on this #{address}"
      redirect_back(fallback_location: root_path)
    elsif subscription.save
      redirect_to new_address_product_billing_path(@address, @product)
    else
      flash[:alert] = "An error has occured. Please contact the support team."
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @address = Address.find(params[:address_id])
    @subscription = Subscription.where(product: @product, address: @address, state: 'draft').first
    @subscription.update(subscription_params)
  end


  def new; end

  private

  def manage_address
    redirect_to new_address_path if current_user.addresses.blank?
  end

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def subscription_params
    params.require(:subscription).permit(:start_date)
  end

end
