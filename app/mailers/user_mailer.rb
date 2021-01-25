class UserMailer < ApplicationMailer

  def welcome_email
    @user = params[:user]
    @locale = I18n.locale
    mail(to: @user.email, subject: I18n.t('mail.welcome_email'))
  end

  def subscription_under_review_email
    @user = params[:user]
    @subscription = params[:subscription]
    @locale = I18n.locale
    mail(to: @user.email, subject: I18n.t('mail.subscription_under_review'))
  end

  def booking_under_review_email
    @user = params[:user]
    @booking = params[:booking]
    @locale = I18n.locale
    mail(to: @user.email, subject: I18n.t('mail.subscription_under_review'))
  end

  def subscription_confirmed_email
    @user = params[:user]
    @subscription = params[:subscription]
    @locale = I18n.locale
    mail(to: @user.email, subject:  I18n.t('mail.subscription_confirmed'))
  end

  def booking_confirmed_email
    @user = params[:user]
    @booking = params[:booking]
    @locale = I18n.locale
    mail(to: @user.email, subject: I18n.t('mail.booking_confirmed'))
  end

end
