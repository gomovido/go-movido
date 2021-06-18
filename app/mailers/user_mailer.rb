class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @locale = params[:locale]
    mail(to: @user.email, subject: I18n.t('mail.welcome_email'))
  end
end
