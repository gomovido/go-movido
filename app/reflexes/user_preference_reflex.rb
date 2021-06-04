class UserPreferenceReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def associate_country
    @user_pref = UserPreference.new(user_preference_params)
    @user_pref.country = Country.find(id: params[:country_id])
    @user_pref.user = current_user
    @user_pref.save
  end

  private

  def user_preference_params
    params.require(:user_preference).permit(:arrival, :stay_duration)
  end
end
