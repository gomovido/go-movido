class UserReflex < ApplicationReflex
  include ActionController::Flash
  before_reflex do
    @user = User.friendly.find(params[:id])
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
    params.require(:user).permit(:email, :first_name, :last_name, :username, :phone,
      :city, :not_housed, :address, :country, :birthdate, :birth_city
    )
  end
end
