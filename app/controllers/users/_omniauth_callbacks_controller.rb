class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

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

  # def facebook
  #   @user = from_omniauth_facebook(request.env["omniauth.auth"])
  #   I18n.locale = request.env["omniauth.params"]["locale"]
  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook' if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
  #   end
  # end

  # def from_omniauth_facebook(auth)
  #   user = User.find_by(provider: auth.provider, uid: auth.uid)
  #   unless user
  #     user = User.create(
  #       email: auth.info.email,
  #       password: Devise.friendly_token[0,20],
  #       first_name: auth.info.name.split(' ')[0],
  #       last_name: auth.info.name.split(' ').drop(1).join('-')
  #     )
  #     UserMailer.with(user: user, locale: locale).welcome_email.deliver_now
  #   end
  #   return user
  # end


  def failure
    flash[:alert] = I18n.t 'flashes.global_failure'
    redirect_to root_path
  end

end
