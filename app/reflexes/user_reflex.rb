class UserReflex < ApplicationReflex
  delegate :current_user, to: :connection

  before_reflex do
    current_user.assign_attributes(user_params)
  end

  def submit
    if current_user.save!
      morph ".subscriptions-wrapper", with_locale {render(partial: "subscriptions", locals: {subscriptions: current_user.subscriptions})}
    else
      morph :nothing
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone, :birthdate, :birth_city)
  end
end
