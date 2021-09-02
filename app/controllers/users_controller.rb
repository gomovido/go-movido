class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, only: [:profile, :update, :edit, :update_password]

  def profile; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Profile updated :)'
      redirect_to dashboard_path
    else
      flash[:notice] = 'An error has occured, please try again.'
      render 'profile'
    end
  end

  def edit; end

  def update_password
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone)
  end
end
