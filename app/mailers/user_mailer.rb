class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @locale = "en"
    mail(to: @user.email, subject: "✨ #{@user.first_name}, welcome to movido !")
  end


  def password_email
    @user = User.find(params[:user_id])
    @locale = "en"
    mail(to: @user.email, subject: "✨ #{@user.first_name}, welcome to movido !")
  end

  def order_confirmed
    @user = params[:user]
    @order = params[:subscription]
    @locale = "en"
    mail(to: @user.email, subject: "✨ #{@user.first_name}, your Starter Pack is on its way !")
  end
end
