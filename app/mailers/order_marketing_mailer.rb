class OrderMarketingMailer < ApplicationMailer
  def retarget
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: "✨ #{@user.first_name}, forgot something?")
  end

  def last_call
    @user = params[:user]
    @order = params[:order]
    mail(to: @user.email, subject: "✨ #{@user.first_name}, hurry up and get ready for your stay abroad! ✈️")
  end

  def feedback
    @user = params[:user]
    mail(to: @user.email, subject: "#{@user.first_name}, your feedback is important to us! 🙏")
  end
end
