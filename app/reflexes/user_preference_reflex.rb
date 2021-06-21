class UserPreferenceReflex < ApplicationReflex
  delegate :current_user, to: :connection

  def create
    @user_preference = current_user.user_preference || UserPreference.new
    @user_preference.assign_attributes(user_preference_params)
    @user_preference.user = current_user
    if @user_preference.save
      morph '.flow-container', render(partial: "steps/cart/new", locals: { order: current_user.current_draft_order || Order.new, user_preference: @user_preference, message: { content: "Almost done! Please select the services you need to get started in your new city", delay: 0 } })
    else
      morph '.form-base', render(partial: "steps/user_preference/form", locals: { user_preference: @user_preference })
    end
  end

  private

  def user_preference_params
    params.require(:user_preference).permit(:arrival, :stay_duration, :country_id)
  end
end
