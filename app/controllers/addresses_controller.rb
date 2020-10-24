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


  def create_subscription(address)
    @product = Product.find(params[:address][:product_id])
    subscription = Subscription.new(product: @product, address: address, state: 'draft')
    if subscription.save
      redirect_to new_address_product_billing_path(@address, @product, subscription_id: subscription.id)
    else
      flash[:alert] = "An error has occured. Please contact the support team."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def address_params
    params.require(:address).permit(:country, :city, :zipcode,
                                  :street, :street_number, :floor,
                                  :internet_status, :phone, :mobile_phone,
                                  :building, :stairs, :door, :gate_code)
  end
end
