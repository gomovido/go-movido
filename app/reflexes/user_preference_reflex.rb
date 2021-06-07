class UserPreferenceReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    @user_pref = UserPreference.new(user_preference_params)
    @user_pref.user = current_user
    if @user_pref.save
      morph '.flow-container', render(partial: "steps/cart")
    else
      morph '.form-base', render(partial: "steps/forms/user_preference", locals: { user_preference: @user_pref })
    end
  end

  private

  def user_preference_params
    params.require(:user_preference).permit(:arrival, :stay_duration, :country_id)
  end
end
