class AddressesController < ApplicationController
  before_action :set_subscription, only: [:edit, :update]

  def new
    @address = Address.new
  end

  def create
    if address_params[:moving_country].present?
      @address = Address.new(country: Country.find_by(code: address_params[:moving_country]))
    else
      @address = Address.new(address_params)
      @address.country = Country.find_by(code: address_params[:algolia_country_code])
    end
    @address.user = current_user
    if @address.save
      redirect_to dashboard_index_path
    else
      render :new
    end
  end

  def edit; end


  def update
    if @subscription.update(subscription_params)
      redirect_to new_subscription_billing_path(@subscription)
    else
      render :edit
    end
  end


  private

  def address_params
    params.require(:address).permit(:street, :zipcode , :city, :moving_country, :algolia_country_code)
  end


  def subscription_params
    params.require(:subscription).permit(:delivery_address, :sim, :contact_phone, :algolia_country_code, billing_attributes: [:address, :bic, :iban, :bank, :user_id], address_attributes: [:id, :floor, :street, :building, :stairs, :door, :gate_code])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end



end
