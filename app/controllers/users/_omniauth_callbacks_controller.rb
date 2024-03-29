module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # rubocop:disable Naming/VariableNumber
    def google_oauth2
      @user = User.from_omniauth_google(request.env)
      I18n.locale = request.env["omniauth.params"]["locale"]
      if @user.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @user, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    end

    # rubocop:enable Naming/VariableNumber
    def failure
      flash[:alert] = I18n.t 'flashes.global_failure'
      redirect_to root_path
    end
  end
end
