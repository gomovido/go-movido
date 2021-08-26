class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = 'Profile updated :)'
      redirect_to dashboard_path
    else
      flash[:notice] = 'An error has occured, please try again.'
      render 'profile'
    end
  end

  def edit
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone)
  end
end
