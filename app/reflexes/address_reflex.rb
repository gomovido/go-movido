class AddressReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex do
    @address = Address.new
    @address.assign_attributes(address_params)
  end

  def submit
    @address.valid_address = true 
    @address.user = current_user
    @address.save
  end

  private

  def address_params
    params.require(:address).permit(:country, :city, :zipcode, :street)
  end
end
