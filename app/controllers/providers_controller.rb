class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    @flat_preference = current_user.flat_preference
    clear_filters
    @uniplaces_payload = uniplaces_flats(@flat_preference.location, @flat_preference.country)
    @uniacco_payload = uniacco_flats(@flat_preference.location)
    @uniacco_flats = @uniacco_payload[:flats]
    @uniplaces_flats = @uniplaces_payload[:flats]
    @count = @uniacco_payload[:count] + @uniplaces_payload[:count]
    return if (@uniacco_flats + @uniplaces_flats).present?

    flash[:alert] = 'Please type another location'
    redirect_to real_estate_path
  end

  def uniplaces_flats(location, country)
    UniplacesApiService.new(city_code: location, country: country, flat_preference_id: current_user.flat_preference.id, page: 1).flats
  end

  def uniacco_flats(location)
    UniaccoApiService.new(city_code: location).flats
  end

  def clear_filters
    current_user.flat_preference.update(range_min_price: nil, range_max_price: nil, facilities: [], flat_type: nil, recommandations: [])
  end
end
