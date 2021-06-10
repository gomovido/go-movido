class CartsController < ApplicationController
  def new
    @user_pref = current_user.user_preference
    @message = { content: "Almost done! Please select the services you need - you can pick and choose across packs if you like", delay: 0 }
  end
end
