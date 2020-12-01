class AddressesController < ApplicationController
  before_action :set_subscription, only: [:update_subscription_address, :update]

  def new
    @address = Address.new
  end

  def create
    if address_params[:moving_country].present?
      @address = generate_fake_address
    else
      @address = Address.new(address_params)
    end
    @address.user = current_user
    if @address.save
      current_user.update(country: @address.country)
      redirect_to dashboard_index_path
    else
      flash[:alert] = 'You must enter an address or a country'
      render :new
    end
  end

  def update_subscription_address
    @subscription = Subscription.find(params[:subscription_id])
  end


  def update
    if @subscription.update(subscription_params)
      redirect_to new_subscription_billing_path(@subscription)
    else
      render :update_subscription_address
    end
  end


  private

  def generate_fake_address
    address = get_address(address_params[:moving_country])
    return Address.new(city: address[:city], street: address[:street], zipcode: address[:zipcode], valid_address: false)
  end

  def get_address(country)
    if country == 'France'
      return {city: 'Paris', street: '3 Avenue des Champs Élysées, Paris 8e Arrondissement, Île-de-France, France', zipcode: '75008'}
    elsif country == 'United Kingdom'
      return {city: 'London', street: '123 London Bridge Street, London Borough of Southwark, England, United Kingdom', zipcode: 'SE1 9SE'}
    end
  end

  def address_params
    params.require(:address).permit(:street, :zipcode , :city, :moving_country)
  end


  def subscription_params
    params.require(:subscription).permit(:delivery_address, :sim, billing_attributes: [:address, :bic, :iban, :bank, :user_id], address_attributes: [:id, :floor, :street, :building, :stairs, :door, :gate_code])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end



end
