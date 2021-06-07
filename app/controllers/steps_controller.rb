class StepsController < ApplicationController
  def simplicity
    @user_preference = current_user.user_preference || UserPreference.new
    @messages = [{ content: "First of all, where are you moving to?", delay: 0 }]
  end
end
