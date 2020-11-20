class SubscriptionsController < ApplicationController

  before_action :set_product, only: [:new, :create]
  before_action :set_subscription, only: [:summary, :validate_subscription, :congratulations, :payment]

  def create
    if @product.category.name != 'mobile'
      create_mobile_subcription(@product, current_user.active_address)
    else
      if current_user.active_address.nil?
        flash[:alert] = "You have to create / select an address in #{@product.country}"
        redirect_to user_path(current_user)
        return
      end
      @subscription = Subscription.new(subscription_params)
      @subscription.address = current_user.active_address
      @subscription.product = @product
      @subscription.billing.iban = sanitized_iban
      @subscription.billing.bic = sanitized_bic
      if @subscription.save
        @subscription.update(state: 'draft')
        redirect_to subscription_summary_path(@subscription)
      else
        @category = @product.category
        render :new
      end
    end
  end

  def create_subcription(product, address)
    draft_subscription = Subscription.find_by(product: product, address: address, state: 'draft')
    @subscription = Subscription.new(subscription_params) unless draft_subscription
    @subscription.address = address
    @subscription.product = product
    if !@subscription
      flash[:alert] = "You already have a subscription on #{address.street}"
      redirect_to new_category_product_subscription_path(address, product)
    elsif Subscription.find_by(address: address, product: product, state: 'pending_processed').nil? && @subscription.save!
      @subscription.update(state: 'draft')
      redirect_to subscription_summary_path(@subscription)
    else
      @category = product.category
      render :new
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
      @subscription.update(state: 'paid')
    elsif @subscription.product.sim_card_price.cents >= 1 && !@subscription.charge
      redirect_to subscription_payment_path(@subscription)
    elsif @subscription.product.sim_card_price.cents >=  1 && @subscription.charge.status != "succeeded"
      redirect_to subscription_payment_path(@subscription)
    else
      @subscription.update(state: 'paid')
      subscription_congratulations_path(@subscription)
    end
  end

  def payment
    @charge = Charge.new
    redirect_to subscription_congratulations_path(@subscription) if @subscription.state == 'paid'
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @subscription = Subscription.new
    @subscription.build_billing
    @category = @product.category
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end

  def sanitized_bic
    params[:subscription][:billing_attributes][:bic].upcase
  end

  def sanitized_iban
    params[:subscription][:billing_attributes][:iban].upcase.gsub(" ","")
  end

  def subscription_params
    params.require(:subscription).permit(:delivery_address, :sim, billing_attributes: [:address, :bic, :iban, :bank, :user_id])
  end

  def set_product
    @product = Product.friendly.find(params[:product_id])
  end

end
