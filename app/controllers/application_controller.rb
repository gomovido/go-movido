class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  if Rails.env.staging?
    http_basic_authenticate_with name: Rails.application.credentials.staging[:http][:username],
                                 password: Rails.application.credentials.staging[:http][:password]
  end

  private

  def after_sign_in_path_for(resource)
    resource.active_address.nil? ? new_user_address_path(resource.id) : dashboard_index_path
  end

  def after_sign_out_path_for(_resource)
    root_path
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym || session[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password password_confirmation])
  end
end
