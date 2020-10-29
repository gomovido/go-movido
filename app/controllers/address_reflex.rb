class AddressReflex < ApplicationReflex
  before_reflex do
    @address = GlobalID::Locator.locate_signed(element.dataset.signed_id)
    @address.assign_attributes(address_params)
  end

  def submit
    @address.save!
  end

  private

  def address_params
    params.require(:address).permit(:country, :city, :zipcode,
                                  :street, :floor,
                                  :internet_status, :phone, :mobile_phone,
                                  :building, :stairs, :door, :gate_code)
  end
end
