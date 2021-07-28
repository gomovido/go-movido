class UserMarketingsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user_marketing = UserMarketing.find(user_id: current_user)
  end

  def unsubscribe
    @user_marketing = UserMarketing.find(user_id: current_user)
    if @user_marketing.update(user_params)
      redirect_to root_path
      flash[:notice] = 'Successfully unsubscribed'
    end
  end

  private

  def user_marketing_params
    params.require(:user_marketing).permit(:subscribed)
  end
  
end
