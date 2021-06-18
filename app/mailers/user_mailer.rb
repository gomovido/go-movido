class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @locale = "en"
    mail(to: @user.email, subject: I18n.t('mail.welcome_email'))
  end

  def order_confirmed
    @user = params[:user]
    @order = params[:subscription]
    @locale = "en"
    mail(to: @user.email, subject: "✨ #{@user.first_name}, your Starter Pack is on its way !")
  end
end
