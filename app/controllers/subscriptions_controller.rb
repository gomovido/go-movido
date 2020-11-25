class SubscriptionsController < ApplicationController

  before_action :set_product, only: [:new, :create, :create_wifi_subcription, :new_wifi]
  before_action :set_subscription, only: [:summary, :validate_subscription, :congratulations, :payment]

  def create
    return if subscription_draft?(@product)
    return if subscription_active?(@product)
    return if active_address_do_not_exist?(@product)
    @subscription = Subscription.new
    @subscription.address = current_user.active_address
    @subscription.product = @product
    if @subscription.save
      @subscription.update(state: 'draft')
      if @product.is_mobile?
        redirect_to new_subscription_billing_path(@subscription)
      elsif @product.is_wifi?
        redirect_to subscription_update_address_path(@subscription, @subscription.address)
      end
    else
      @category = @product.category
      redirect_back(fallback_location: root_path)
    end
  end

  def summary; end

  def validate_subscription
    if @subscription.update(state: 'pending_processed')
      if @subscription.product.sim_card_price.cents >= 1
        redirect_to subscription_payment_path(@subscription)
      else
        redirect_to subscription_congratulations_path(@subscription)
      end
    end
  end

  def congratulations
    if @subscription.product.sim_card_price.cents <  1
      @subscription.update(state: 'succeeded')
    elsif @subscription.product.sim_card_price.cents >= 1 && !@subscription.charge
      redirect_to subscription_payment_path(@subscription)
    elsif @subscription.product.sim_card_price.cents >=  1 && @subscription.charge.status != "succeeded"
      redirect_to subscription_congratulations_path(@subscription)
    end
  end

  def payment
    @charge = Charge.new
    redirect_to subscription_congratulations_path(@subscription) if @subscription.state == 'succeeded'
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  private

  def active_address_do_not_exist?(product)
    if current_user.active_address.nil? || (!current_user.active_address.valid_address && product.category.name != 'mobile')
      redirect_to user_path(current_user)
      flash[:alert] = "You have to create / select an address in #{product.country}"
    end
  end

  def subscription_active?(product)
    subscription_check = Subscription.find_by(state: 'succeeded', product: product, address: current_user.active_address)
    if subscription_check && product.category.name != 'mobile'
      redirect_to subscription_congratulations_path(subscription_check)
      flash[:alert] = 'You already have this subscription !'
    end
  end

  def subscription_draft?(product)
    subscription_check = Subscription.find_by(state: 'draft', product: product, address: current_user.active_address)
    if subscription_check && product.category.name == 'mobile'
      redirect_to new_subscription_billing_path(subscription_check)
    elsif subscription_check && product.category.name == 'wifi'
      redirect_to subscription_update_address_path(subscription_check, subscription_check.address)
    end
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end

  def subscription_params
    params.require(:subscription).permit(:delivery_address, :sim, billing_attributes: [:address, :bic, :iban, :bank, :user_id], address_attributes: [:id, :floor, :street, :building, :stairs, :door, :gate_code])
  end

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

end
