class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    @flat_preference = current_user.flat_preference
    clear_filters
    @uniplaces_payload = uniplaces_flats(@flat_preference.location, @flat_preference.country)
    @uniacco_payload = uniacco_flats(@flat_preference.location)
    @flats = @uniacco_payload + @uniplaces_payload
    return if @flats.present?

    flash[:alert] = 'Please type another location'
    redirect_to real_estate_path
  end

  def uniplaces_flats(location, country)
    payload = UniplacesApiService.new(city_code: location, country: country, flat_preference_id: current_user.flat_preference.id, page: 1).list_flats
    if payload && payload[:status] == 200
      payload[:flats]
    else
      []
    end
  end

  def uniacco_flats(location)
    payload = UniaccoApiService.new(city_code: location).list_flats
    if payload[:status] == 200 && current_user.flat_preference.update(codes: payload[:codes])
      payload[:flats]
    else
      []
    end
  end

  def clear_filters
    current_user.flat_preference.update(range_min_price: nil, range_max_price: nil, microwave: false, dishwasher: false, move_in: Time.zone.today, move_out: Time.zone.today + 30.days, flat_type: nil)
  end
end
