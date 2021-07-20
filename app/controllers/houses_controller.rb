class HousesController < ApplicationController
  def new
    @pack = params[:pack]
    @house = current_user.house || House.new
    @house_detail = current_user&.house&.house_detail || HouseDetail.new
    @message = { content: "Great, #{current_user.first_name}! First of all, tell me more about your move. Where are you going to?", delay: 0 }
  end
end
