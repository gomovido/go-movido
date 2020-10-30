class SubscriptionsController < ApplicationController

  before_action :set_product, only: [:new, :create, :update]

  def create
    @address = Address.find(params[:address_id])
    draft_subscription = Subscription.find_by(product: @product, address: @address, state: 'draft')
    subscription = Subscription.new(product: @product, address: @address, state: 'draft') unless draft_subscription
    if !subscription
      redirect_to new_address_product_billing_path(@address, @product, subscription_id: draft_subscription.id)
    elsif Subscription.find_by(address: @address, product: @product, state: 'pending_processed').nil? && subscription.save
      redirect_to new_address_product_billing_path(@address, @product, subscription_id: subscription.id)
    else
      flash[:alert] = "You already have a subscription on #{@address.street}"
      redirect_to dashboard_index_path
    end
  end

  def summary
    @subscription = Subscription.find(params[:subscription_id])
  end

  def validate_subscription
    @subscription = Subscription.find(params[:subscription_id])
    if @subscription.update(state: 'pending_processed')
      flash[:notice] = "Your subscription is being processed"
      redirect_to dashboard_index_path
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @address = Address.new
    @active_address = Address.find_by(user: current_user, active: true)
  end

  private

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

end
