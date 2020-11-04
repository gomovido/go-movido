class SubscriptionsController < ApplicationController

  before_action :set_product, only: [:new, :create, :update]

  def create
    if @product.category.name == 'mobile'
      create_mobile_subcription(@product, current_user.active_address)
    else
      subscription = Subscription.new(subscription_params)
      if subscription.save
        redirect_to subscription_summary(@subscription)
      else
        render 'new'
      end
    end
  end

  def create_mobile_subcription(product, address)
    draft_subscription = Subscription.find_by(product: @product, address: @address, state: 'draft')
    subscription = Subscription.new(subscription_params) unless draft_subscription
    if !subscription
      redirect_to new_category_product_subscription_path(@address, @product)
    elsif Subscription.find_by(address: @address, product: @product, state: 'pending_processed').nil? && subscription.save
      subscription.update(state: 'draft')
      redirect_to subscription_summary(@subscription)
    else
      flash[:alert] = "You already have a subscription on #{@address.street}"
      render 'new'
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
    @active_address = current_user.active_address
    @subscription = Subscription.new
    @subscription.build_billing
    @category = @product.category
  end

  private

  def subscription_params
    params.require(:subscription).permit(:delivery_address, billing_attributes: [:address, :first_name, :last_name, :bic, :iban, :bank])
  end

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

end
