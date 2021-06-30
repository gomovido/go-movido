class HousesController < ApplicationController
  def new
    @house = current_user.house || House.new
    @message = { content: "Great, #{current_user.first_name}! First of all, tell me more about your move. Where do you go?", delay: 0 }
  end
end
