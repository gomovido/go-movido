class UserMarketingMailer < ApplicationMailer
  def retarget
    @user = params[:user]
    mail(to: @user.email, subject: "#{@user.first_name}, studying abroad this fall ?")
  end

  def second_call
    @user = params[:user]
    mail(to: @user.email, subject: "✨ #{@user.first_name}, get prepared for your stay abroad  ✈️ ")
  end

  def last_call
    @user = params[:user]
    mail(to: @user.email, subject: "✨ #{@user.first_name}, last call for your move abroad 🛫")
  end

end
