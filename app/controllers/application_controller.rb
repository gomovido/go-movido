class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action -> { I18n.backend.reload! } if Rails.env.development?

  private

  def after_sign_in_path_for(resource)
    resource.active_address.nil? ? new_user_address_path(resource.id) : dashboard_index_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def user_has_address?
    redirect_to(new_user_address_path(current_user.id)) if current_user.active_address.nil?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [
        :email, :first_name, :last_name, :phone, :birthdate, :city, :locale,
        :country, :not_housed, :birth_city, addresses_attributes: [:street, :zipcode, :country, :city]
      ]
    )
    devise_parameter_sanitizer.permit(:sign_in,
      keys: [
        :email, :password, :password_confirmation
      ]
    )
  end
end
