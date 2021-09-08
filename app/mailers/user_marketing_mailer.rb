class UserMarketingMailer < ApplicationMailer
  def retarget
    @user = params[:user]
    mail(to: @user.email, subject: "👋 #{@user.first_name}, Get started  to Movido! ")
  end

  def second_call
    @user = params[:user]
    mail(to: @user.email, subject: "💸 #{@user.first_name}, get 20% off your Movido Settle-in Pack")
  end

  def last_call
    @user = params[:user]
    mail(to: @user.email, subject: "💸 #{@user.first_name}, last chance to get 20% off your Settle-In Pack ")
  end
end
