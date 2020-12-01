class UsersController < ApplicationController
  def show
    @address = Address.new
    @user = User.friendly.find(params[:id])
    if @user != current_user
      flash[:alert] = 'Your are not allowed to see this page'
      redirect_to root_path
    end
  end


  def update
    @subscription = Subscription.find(params[:subscription_id])
    if current_user.update(user_params)
      if @subscription.product.is_mobile?
        redirect_to new_subscription_billing_path(@subscription)
      elsif @subsription.product.is_wifi?
        redirect_to subscription_update_address_path(@subscription, @subscription.address)
      end
    else
      flash[:alert] = 'You must complete your profile to continue'
      @user = current_user
      render :complete_profil
    end
  end


  def complete_profil
    @user = current_user
  end


  private

  def user_params
    params.require(:user).permit(:phone, :birthdate, :birth_city)
  end

end
