class UsersController < ApplicationController
  def show
    @address = Address.new
    @user = User.friendly.find(params[:id])
    if @user != current_user
      flash[:alert] = 'Your are not allowed to see this page'
      redirect_to root_path
    end
  end
end
