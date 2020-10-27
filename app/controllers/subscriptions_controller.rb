class SubscriptionsController < ApplicationController

  before_action :set_product, only: [:new, :create, :update]

  def create
    @address = Address.find(params[:address_id])
    subscription = Subscription.new(product: @product, address: @address, state: 'draft')
    subscriptions = Subscription.where(product: @product, address: @address, state: 'draft')
    if subscriptions.length > 1
      flash[:alert] = "You already have a pending subscription for #{@product} on this #{@address}"
      redirect_to subscription_path(subscriptions[0])
    elsif subscription.save
      redirect_to new_address_product_billing_path(@address, @product, subscription_id: subscription.id)
    else
      flash[:alert] = "An error has occured. Please contact the support team."
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @address = Address.find(params[:address_id])
    @subscription = Subscription.find(params[:id])
    if @subscription.update(subscription_params)
      @subscription.update(state: 'pending_processed')
      flash[:notice] = "Your subscription is being processed"
      redirect_to dashboard_index_path
    end
  end


  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @address = Address.new
  end

  private

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

  def subscription_params
    params.require(:subscription).permit(:start_date)
  end

end
