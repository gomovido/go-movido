class UserReflex < ApplicationReflex
  delegate :current_user, to: :connection

  before_reflex do
    current_user.assign_attributes(user_params)
  end

  def submit
    with_locale { current_user.save! }
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, person_attributes: %i[phone birthdate birth_city id])
  end
end
