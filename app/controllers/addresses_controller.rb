class AddressesController < ApplicationController

  def create
    @address = Address.new(address_params)
    @address.user = current_user
    if @address.save
      flash[:notice] = 'Address is created!'
      redirect_to user_path(current_user)
    else
      flash[:alert] = "An error has occured. Please contact the support team."
      redirect_back(fallback_location: root_path)
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
