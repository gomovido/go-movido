class UserReflex < ApplicationReflex
  include ActionController::Flash
  before_reflex do
    @user = GlobalID::Locator.locate_signed(element.dataset.signed_id)
    @user.assign_attributes(user_params)
  end

  after_reflex do
    ##flash[:notice] = 'saved'
  end

  def submit
    @user.save
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :username,
      :already_moved, :moving_date, :phone,
      :city, :not_housed, :address
    )
  end
end
