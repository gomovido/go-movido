class SubscriptionsController < ApplicationController
  before_action :set_product, only: [:create]
  before_action :set_subscription, only: [:summary, :validate_subscription, :congratulations, :payment, :abort_subscription]
  skip_before_action :verify_authenticity_token, only: [:send_confirmed_email]
  skip_before_action :authenticate_user!, only: [:send_confirmed_email]
  http_basic_authenticate_with name: Rails.application.credentials.development[:forest_admin][:api_name], password: Rails.application.credentials.development[:forest_admin][:api_secret], only: [:send_confirmed_email] if Rails.env.development?
  http_basic_authenticate_with name: Rails.application.credentials.staging[:forest_admin][:api_name], password: Rails.application.credentials.staging[:forest_admin][:api_secret], only: [:send_confirmed_email] if Rails.env.staging?
  http_basic_authenticate_with name: Rails.application.credentials.production[:forest_admin][:api_name], password: Rails.application.credentials.production[:forest_admin][:api_secret], only: [:send_confirmed_email] if Rails.env.production?


  def create
    return if subscription_active?(@product)
    subscription = @product.subscriptions.find_by(address: current_user.active_address, state: 'draft')
    if subscription
      redirect_to subscription.path_to_first_step
      return
    else
      @product.subscriptions.find_by(address: current_user.active_address, state: 'draft')
      @subscription = Subscription.new
      @subscription.product = @product
      @subscription.address = current_user.active_address
      @subscription.state = 'draft'
      if @subscription.save
        return if user_profil_is_uncomplete?
        redirect_to edit_subscription_address_path(@subscription, @subscription.address)
      else
        redirect_back(fallback_location: root_path, locale: I18n.locale)
      end
    end
  end

  def summary; end

  def validate_subscription
    if @subscription.product_is_mobile? && @subscription.product.has_payment?
      @subscription.update(state: 'pending_processed', locale: I18n.locale)
      redirect_to subscription_payment_path(@subscription)
    else
      @subscription.update(state: 'succeeded', locale: I18n.locale)
      UserMailer.with(user: @subscription.address.user, subscription: @subscription, locale: @subscription.locale).subscription_under_review_email.deliver_now
      redirect_to subscription_congratulations_path(@subscription)
    end
  end

  def congratulations
    redirect_to subscription_payment_path(@subscription) if !@subscription.state == 'succeeded'
    actual_category = @subscription.product.category.name
    @categories = Category.where.not(name: actual_category).where(open: true)
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

  def abort_subscription
    if @subscription.state == 'draft'
      @subscription.update_columns(state: 'aborted')
      flash[:alert] = I18n.t 'flashes.subscription_aborted'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = I18n.t 'flashes.global_failure'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def user_profil_is_uncomplete?
    redirect_to new_subscription_person_path(@subscription) if !current_user.is_complete?
  end

  def subscription_active?(product)
    subscription_check = Subscription.find_by(state: 'succeeded', product: product, address: current_user.active_address)
    if subscription_check && product.category.name != 'mobile'
      redirect_to subscription_congratulations_path(subscription_check)
      flash[:alert] = I18n.t 'flashes.existing_subscription'
    end
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end

  def set_product
    if params[:product_type] == 'Wifi'
      @product = Wifi.find(params[:product_id])
    elsif params[:product_type] == 'Mobile'
      @product = Mobile.find(params[:product_id])
    end
  end

  def subscription_params
    params.require(:subscription).permit(:delivery_address, :sim, billing_attributes: [:address, :bic, :iban, :bank, :user_id], address_attributes: [:id, :floor, :street, :building, :stairs, :door, :gate_code])
  end

end
