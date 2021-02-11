class AddressReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def default
    address = Address.find(element.dataset.id)
    address.set_has_active
    current_user.update_user_country
    morph ".subscriptions-wrapper", with_locale {render(partial: "users/desktop/subscriptions", locals: {subscriptions: current_user.subscriptions})}
    morph ".addresses-container",  with_locale {render(partial: "users/desktop/addresses", locals: {address: Address.new, active_address: address, addresses: current_user.addresses.where(active: false)})}
  end

  def create
    @address = Address.new
    @address.assign_attributes(address_params)
    @address.valid_address = true
    @address.user = current_user
    if @address.save
      @address.set_has_active
      current_user.update_user_country
      morph ".subscriptions-wrapper", with_locale {render(partial: "users/desktop/subscriptions", locals: {subscriptions: current_user.subscriptions})}
      morph ".addresses-container",  with_locale {render(partial: "users/desktop/addresses", locals: {address: Address.new, active_address: @address, addresses: current_user.addresses.where(active: false)})}
    else
      morph '#error', with_locale {I18n.t('users.addresses.form.failure.street')}
    end
  end

  def create_with_modal
    @address = current_user.active_address.valid_address ? current_user.active_address : Address.new
    @address.assign_attributes(address_params)
    @address.valid_address = true
    @address.user = current_user
    if @address.save!
      @address.set_has_active
      current_user.update_user_country
      morph :nothing
    end
  end



  private

  def address_params
    params.require(:address).permit(:city, :zipcode, :street)
  end
end
