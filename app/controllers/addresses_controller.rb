class AddressesController < ApplicationController
  before_action :set_subscription, only: [:edit, :update]

  def new
    @address = Address.new
  end

  def create
    if address_params[:moving_country].present?
      @address = generate_fake_address
    else
      @address = Address.new(address_params)
      @address.valid_address = true
    end
    @address.user = current_user
    if @address.save
      current_user.update_columns(country: @address.country)
      redirect_to dashboard_index_path
    else
      render :new
    end
  end

  def edit
    return if active_address_do_not_exist?(@subscription.product)
    redirect_to subscription_complete_profil_path(@subscription) if !current_user.is_complete?
  end


  def update
    if @subscription.update(subscription_params)
      redirect_to new_subscription_billing_path(@subscription)
    else
      render :edit
    end
  end


  private

  def active_address_do_not_exist?(product)
    if current_user.active_address.nil? || (!current_user.active_address.valid_address && !product.is_mobile?)
      redirect_to user_path(current_user)
      flash[:alert] = I18n.t 'flashes.wrong_country', country: product.country
    end
  end

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
