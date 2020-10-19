class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  private

  def after_sign_in_path_for(resource)
    dashboard_index_path
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

 protected

 def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [
        :email, :first_name, :last_name,
        :already_moved, :moving_date, :phone,
        :city, :not_housed, :address
      ]
    )
    devise_parameter_sanitizer.permit(:sign_in,
      keys: [
        :email, :password, :password_confirmation
      ]
    )
 end
end
