class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    @flat_preference = current_user.flat_preference
    payload = UniaccoApiService.new(city_code: @flat_preference.location).list_flats
    if payload[:status] == 200 && update_preferences(payload)
      @flats = payload[:flats]
    else
      flash[:alert] = 'Please type another location'
      redirect_to real_estate_path
    end
  end

  def update_preferences(payload)
    current_user.flat_preference.update(start_min_price: payload[:min_price], start_max_price: payload[:max_price], recommandations: payload[:recommandations], codes: payload[:codes])
  end
end
