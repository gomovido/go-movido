class UserMarketingsController < ApplicationController
  skip_before_action :authenticate_user!

  def unsubscribe_confimation
    @user = User.find(Base64.decode64(params[:user_id]).to_i)
    @user_marketing = UserMarketing.find_by(user: @user) if @user
    redirect_to root_path if @user_marketing.nil?
  end

  def unsubscribe
    user_marketing = UserMarketing.find_by(user: Base64.decode64(params[:user_id]).to_i)
    if user_marketing
      user_marketing.update(subscribed: false) ? flash[:notice] = 'Successfully unsubscribed' : flash[:alert] = 'An error has occured, please try again later...'
    end
    redirect_to root_path
  end
end
