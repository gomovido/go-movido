class AddressesController < ApplicationController

  def create
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
      create_subscription(@address)
    else
      flash[:alert] = "An error has occured. Please contact the support team."
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      create_subscription(@address)
    else
      flash[:alert] = "All fields are required"
      redirect_back(fallback_location: root_path)
    end
  end


  def create_subscription(address)
    @product = Product.find(params[:address][:product_id])
    draft_subscription = Subscription.find_by(product: @product, address: address, state: 'draft')
    subscription = Subscription.new(product: @product, address: address, state: 'draft') unless draft_subscription
    if !subscription
      redirect_to new_address_product_billing_path(address, @product, subscription_id: draft_subscription.id)
    elsif Subscription.find_by(address: @address, product: @product, state: 'pending_processed').nil? && subscription.save
      redirect_to new_address_product_billing_path(@address, @product, subscription_id: subscription.id)
    else
      flash[:alert] = "You already have a subscription on #{@address.street}"
      redirect_to dashboard_index_path
    end
  end

  private

  def address_params
    params.require(:address).permit(:country, :city, :zipcode,
                                  :street, :floor,
                                  :internet_status, :mobile_phone, :phoned,
                                  :building, :stairs, :door, :gate_code)
  end
end
