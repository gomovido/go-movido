class UserPreferenceReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    @user_pref = current_user.user_preference || UserPreference.new
    @user_pref.assign_attributes(user_preference_params)
    @user_pref.user = current_user
    if @user_pref.save
      morph '.flow-container', render(partial: "steps/cart/cart", locals: { user_preference: @user_pref, messages: [{ content: "Almost done! Please select the services you need - you can pick and choose across packs if you like", delay: 0 }] })
    else
      morph '.form-base', render(partial: "steps/user_preference/user_preference_form", locals: { user_preference: @user_pref })
    end
  end

  private

  def user_preference_params
    params.require(:user_preference).permit(:arrival, :stay_duration, :country_id)
  end
end
