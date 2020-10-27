class SessionsController < Devise::SessionsController
  after_action :prepare_intercom_shutdown, only: [:destroy]

  protected

  def prepare_intercom_shutdown
    IntercomRails::ShutdownHelper::intercom_shutdown_helper(cookies)
  end


 def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_in,
    keys: [
      :email, :password, :password_confirmation
    ]
  )
 end

end
