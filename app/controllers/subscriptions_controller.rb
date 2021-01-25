class SubscriptionsController < ApplicationController
  before_action :set_product, only: [:new, :create, :create_wifi_subcription, :new_wifi]
  before_action :set_subscription, only: [:summary, :validate_subscription, :congratulations, :payment]
  skip_before_action :verify_authenticity_token, only: [:send_confirmed_email]
  skip_before_action :authenticate_user!, only: [:send_confirmed_email]
  http_basic_authenticate_with name: ENV['API_NAME'], password: ENV['API_SECRET'], only: [:send_confirmed_email]

  def create
    return if subscription_draft?(@product)
    return if subscription_active?(@product)
    return if active_address_do_not_exist?(@product)
    @subscription = Subscription.new
    @subscription.address = current_user.active_address
    @subscription.product = @product
    @subscription.state = 'draft'
    if @subscription.save
      return if user_profil_is_uncomplete?
      if @product.is_mobile?
        redirect_to new_subscription_billing_path(@subscription)
      elsif @product.is_wifi?
        redirect_to edit_subscription_address_path(@subscription, @subscription.address)
      end
    else
      @category = @product.category
      redirect_back(fallback_location: root_path)
    end
  end

  def summary; end

  def validate_subscription
    if @subscription.product.is_mobile? && @subscription.product.has_payment?
      @subscription.update(state: 'pending_processed', locale: I18n.locale)
      redirect_to subscription_payment_path(@subscription)
    else
      @subscription.update(state: 'succeeded', locale: I18n.locale)
      redirect_to subscription_congratulations_path(@subscription)
    end
  end

  def congratulations
    redirect_to subscription_payment_path(@subscription) if !@subscription.state == 'succeeded'
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def modal
    @subscription = Subscription.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def send_confirmed_email
    subscription = Subscription.find(params[:subscription_id])
    UserMailer.with(user: subscription.address.user, subscription: subscription, locale: subscription.locale).subscription_confirmed_email.deliver_now
  end

  private

  def user_profil_is_uncomplete?
    if !current_user.is_complete?
      redirect_to subscription_complete_profil_path(@subscription)
    end
  end

  def active_address_do_not_exist?(product)
    if current_user.active_address.nil? || (!current_user.active_address.valid_address && !product.is_mobile?)
      redirect_to user_path(current_user)
      flash[:alert] = I18n.t 'flashes.wrong_country', country: t("country.#{product.country_code}")
    end
  end

  def subscription_active?(product)
    subscription_check = Subscription.find_by(state: 'succeeded', product: product, address: current_user.active_address)
    if subscription_check && product.category.name != 'mobile'
      redirect_to subscription_congratulations_path(subscription_check)
      flash[:alert] = I18n.t 'flashes.existing_subscription'
    end
  end

  def subscription_draft?(product)
    subscription_check = Subscription.find_by(state: 'draft', product: product, address: current_user.active_address)
    if subscription_check && !current_user.is_complete?
      @subscription = subscription_check
      redirect_to subscription_complete_profil_path(@subscription)
    elsif subscription_check && product.is_mobile?
      redirect_to new_subscription_billing_path(subscription_check)
    elsif subscription_check && product.is_wifi?
      redirect_to edit_subscription_address_path(subscription_check, subscription_check.address)
    end
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end

  def subscription_params
    params.require(:subscription).permit(:delivery_address, :sim, billing_attributes: [:address, :bic, :iban, :bank, :user_id], address_attributes: [:id, :floor, :street, :building, :stairs, :door, :gate_code])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

end
