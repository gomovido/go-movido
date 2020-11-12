class UserMailer < ApplicationMailer

  def welcome
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to movido')
  end

  def congratulations
    @user = params[:user]
    @subscription = params[:subscription]
    mail(to: @user.email, subject: 'Congratulations on your purshase')
  end
end
