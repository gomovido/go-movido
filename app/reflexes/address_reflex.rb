class AddressReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex :set_browser, only: [:default, :create]


  def default
    address = Address.find(element.dataset.id)
    address.set_has_active
    morph ".subscriptions-wrapper", with_locale {render(partial: "users/#{@browser.device.mobile? ? 'mobile' : 'desktop'}/subscriptions", locals: {subscriptions: current_user.subscriptions})}
    morph ".addresses-container",  with_locale {render(partial: "users/#{@browser.device.mobile? ? 'mobile' : 'desktop'}/addresses", locals: {address: Address.new, active_address: address, addresses: current_user.addresses.where(active: false)})}
  end

  def create
    @address = Address.new
    @address.assign_attributes(address_params)
    @address.country = Country.find_by(code: address_params[:algolia_country_code])
    @address.user = current_user
    if @address.save!
      @address.set_has_active
      morph ".subscriptions-wrapper", with_locale {render(partial: "users/#{@browser.device.mobile? ? 'mobile' : 'desktop'}/subscriptions", locals: {subscriptions: current_user.subscriptions})}
      morph ".addresses-container",  with_locale {render(partial: "users/#{@browser.device.mobile? ? 'mobile' : 'desktop'}/addresses", locals: {address: Address.new, active_address: @address, addresses: current_user.addresses.where(active: false)})}
    else
      morph '#error', with_locale {I18n.t('users.addresses.form.failure.street')}
    end
  end

  def create_with_modal
    @address = current_user.active_address.is_complete? ? current_user.active_address : Address.new
    @address.assign_attributes(address_params)
    @address.country = Country.find_by(code: address_params[:algolia_country_code])
    @address.user = current_user
    if @address.save!
      @address.set_has_active
      morph :nothing
    end
  end



  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def address_params
    params.require(:address).permit(:city, :zipcode, :street, :algolia_country_code)
  end
end
