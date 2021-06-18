class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :http_auth, unless: -> { @stimulus_reflex }
  protect_from_forgery prepend: true

  private

  def http_auth
    return unless Rails.env.staging?

    http_basic_authenticate_or_request_with name: Rails.application.credentials.staging[:http][:username],
                                            password: Rails.application.credentials.staging[:http][:password]
  end

  def after_sign_in_path_for(resource)
    resource.paid_orders? ? dashboard_path : new_user_preference_path
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym || session[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def redirect_if_order_is_paid
    redirect_to dashboard_path if Order.find(params[:order_id]).paid?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password password_confirmation])
  end
end
