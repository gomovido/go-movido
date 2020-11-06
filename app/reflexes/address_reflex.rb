class AddressReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex do
    @address = Address.new
    @address.assign_attributes(address_params)
  end

  def submit
    p "I'm in the reflex submit"
    p @address
    @address.user = current_user
    @address.save
  end

  private

  def address_params
    params.require(:address).permit(:country, :city, :zipcode, :street)
  end
end
