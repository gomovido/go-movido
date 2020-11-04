class UserReflex < ApplicationReflex
  delegate :current_user, to: :connection
  include ActionController::Flash
  before_reflex do
    current_user.assign_attributes(user_params)
  end

  after_reflex do
    ##flash[:notice] = 'saved'
  end

  def submit
    current_user.save
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :username, :phone,
      :city, :not_housed, :address
    )
  end
end
