class SubscriptionsController < ApplicationController

  before_action :set_product, only: [:new, :create]
  before_action :manage_address, only: [:new, :create]

  def create
    @address = Address.find(params[:address_id])
    subscription = Subscription.new(product: @product, address: @address, state: 'draft')
    if subscription.save
      ## Here redirect to step 2
      redirect_to new_subscription_path(product_id: @product.id)
    else
      flash[:alert] = "An error has occured. Please contact the support team."
      redirect_back(fallback_location: root_path)
    end
  end


  def new
  end

  private

  def manage_address
    redirect_to new_address_path if current_user.addresses.blank?
  end

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

end
