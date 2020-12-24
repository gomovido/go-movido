class AddressReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def default
    address = Address.find(element.dataset.id)
    address.set_has_active
  end

  def submit
    @address = Address.new
    @address.assign_attributes(address_params)
    @address.valid_address = true
    @address.user = current_user
    if @address.save
      @address.set_has_active
    end
  end

  after_reflex do
    current_user.update_user_country
    morph ".subscriptions-wrapper", with_locale {render(partial: "subscriptions", locals: {subscriptions: current_user.subscriptions})}
    morph ".addresses-container",  with_locale {render(partial: "addresses", locals: {address: Address.new})}
  end

  private

  def address_params
    params.require(:address).permit(:city, :zipcode, :street)
  end
end
