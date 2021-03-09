class BillingsController < ApplicationController
  before_action :set_subscription, only: %i[new create update]

  def new
    fill_country_code
    if current_user.complete?
      @billing = @subscription.billing.nil? ? Billing.new : @subscription.billing
      @billing.build_subscription(delivery_address: @subscription.delivery_address) if @subscription.product_is_mobile?
      render :new
    else
      redirect_to new_subscription_person_path(@subscription)
    end
  end

  def create
    @billing = Billing.new
    @billing.user = current_user
    @billing.subscription = @subscription
    @billing.update(billing_params)

    if @billing.save
      redirect_to subscription_summary_path(@billing.subscription)
    else
      render :new
    end
  end

  def update
    @billing = @subscription.billing
    if @billing.update(billing_params)
      redirect_to subscription_summary_path(@billing.subscription)
    else
      render :new
    end
  end

  private

  def fill_country_code
    if @subscription.delivery_address
      countries = I18n.available_locales.map { |locale| I18n.t("country.#{@subscription.address.country.code}", locale: locale) }
      delivery_address_country = @subscription.delivery_address.split(',').last.strip
      @country_code = @subscription.address.country.code if countries.include?(delivery_address_country)
    else
      @country_code = current_user.active_address.country.code
    end
  end

  def billing_params
    params.require(:billing).permit(:address, :iban, :holder_name, :subscription_id, :algolia_country_code, :account_number, :sort_code,
                                    subscription_attributes: %i[id delivery_address sim])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end
end
