class UserPreferencesController < ApplicationController
  def new
    @user_preference = current_user.user_preference || UserPreference.new
    @messages = [{ content: "Great, #{current_user.first_name}! First of all, tell me more about your move ", delay: 0 }]
  end
end
