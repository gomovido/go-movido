class UserReflex < ApplicationReflex
  delegate :current_user, to: :connection

  before_reflex do
    current_user.assign_attributes(user_params)
  end

  def submit
    morph :nothing unless with_locale{current_user.save!}
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone, :birthdate, :birth_city)
  end
end
