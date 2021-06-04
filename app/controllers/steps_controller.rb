class StepsController < ApplicationController
  def simplicity
    @user_preference = UserPreference.new
  end
end
