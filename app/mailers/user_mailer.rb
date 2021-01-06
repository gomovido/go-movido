class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to movido')
  end

  def subscription_under_review_email
    @user = params[:user]
    @subscription = params[:subscription]
    mail(to: @user.email, subject: 'Congratulations on your purshase')
  end

  def booking_under_review_email
    @user = params[:user]
    @booking = params[:booking]
    mail(to: @user.email, subject: 'Congratulations on your booking')
  end

  def subscription_confirmed_email
    @user = params[:user]
    @subscription = params[:subscription]
    mail(to: @user.email, subject: 'Subscription confirmed')
  end

end
