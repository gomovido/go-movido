class AddressReflex < ApplicationReflex
  delegate :current_user, to: :connection
  include ActionController::Flash

  def default
    address = Address.find(element.dataset["address-id"])
    if address.country == current_user.country
      Address.where(active: true, user: current_user).each {|a| a.update_columns(active: false)}
      address.update_columns(active: true)
    end
  end

  def submit
    @address = Address.new
    @address.assign_attributes(address_params)
    @address.valid_address = true
    @address.user = current_user
    @address.save
  end

  private

  def address_params
    params.require(:address).permit(:country, :city, :zipcode, :street)
  end
end
