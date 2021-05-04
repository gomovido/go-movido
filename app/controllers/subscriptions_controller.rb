class SubscriptionsController < ApplicationController
  before_action :set_product, only: [:create]
  before_action :set_subscription, only: %i[summary validate_subscription congratulations abort_subscription]

  def create
    return if subscription_active?(@product)

    subscription = @product.subscriptions.find_by(address: current_user.active_address, state: 'draft')
    if subscription
      return if user_profil_is_uncomplete?(subscription)

      redirect_to subscription.path_to_first_step
    else
      @product.subscriptions.find_by(address: current_user.active_address, state: 'draft')
      @subscription = Subscription.new
      @subscription.product = @product
      @subscription.address = current_user.active_address
      @subscription.state = 'draft'
      if @subscription.save
        return if user_profil_is_uncomplete?(@subscription)

        redirect_to @subscription.path_to_first_step
      else
        redirect_back(fallback_location: root_path, locale: I18n.locale)
      end
    end
  end

  def summary
    redirect_to subscription_congratulations_path(@subscription) if @subscription.state == 'succeeded'
  end

  def validate_subscription
    if @subscription.product_is_mobile? && @subscription.product.payment?
      @subscription.update_columns(state: 'pending_processed', locale: I18n.locale)
      StripeApiOrderService.new(user_id: current_user.id).create_order
      redirect_to subscription_payment_path(@subscription)
    else
      @subscription.update_columns(state: 'succeeded', locale: I18n.locale, password: @subscription.random_password)
      UserMailer.with(user: @subscription.address.user, subscription: @subscription,
                      locale: @subscription.locale).subscription_under_review_email.deliver_now
      @subscription.slack_notification
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

  def abort_subscription
    if @subscription.state == 'draft'
      @subscription.update_columns(state: 'aborted')
      flash[:alert] = I18n.t 'flashes.subscription_aborted'
    else
      flash[:alert] = I18n.t 'flashes.global_failure'
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def user_profil_is_uncomplete?(subscription)
    redirect_to new_subscription_person_path(subscription) unless current_user.complete?
  end

  def subscription_active?(product)
    subscription_check = Subscription.find_by(state: 'succeeded', product: product, address: current_user.active_address)
    return unless subscription_check&.product_is_wifi?

    redirect_to subscription_congratulations_path(subscription_check)
    flash[:alert] = I18n.t 'flashes.existing_subscription'
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end

  def set_product
    case params[:product_type]
    when 'Wifi'
      @product = Wifi.find(params[:product_id])
    when 'Mobile'
      @product = Mobile.find(params[:product_id])
    end
  end

  def subscription_params
    params.require(:subscription).permit(:delivery_address, :sim, billing_attributes: %i[address bic iban bank user_id],
                                                                  address_attributes: %i[id floor street building stairs door gate_code])
  end
end
