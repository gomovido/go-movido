class AddressReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def default
    address = Address.find(element.dataset["address-id"])
    address.set_has_active
  end

  def submit
    @address = Address.new
    @address.assign_attributes(address_params)
    @address.user = current_user
    @address.set_has_active if @address.save
  end

  after_reflex do
    current_user.update_user_country
  end

  private

  def address_params
    params.require(:address).permit(:city, :zipcode, :street)
  end
end
