class UsersController < ApplicationController
  before_action :user_has_address?, only: [:show]

  def show
    @address = Address.new
    @user = User.friendly.find(params[:id])
    @user.build_person if @user.person.nil?
    @subscriptions = current_user.subscriptions.where.not(state: 'aborted')
    return if @user == current_user

    flash[:alert] = I18n.t 'flashes.not_allowed'
    redirect_to root_path
  end
end
