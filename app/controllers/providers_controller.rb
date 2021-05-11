class ProvidersController < ApplicationController
  def index
    @flat_preference = current_user.flat_preference
    unless @flat_preference
      redirect_to real_estate_path
      return
    end
    clear_filters
    @uniplaces_payload = uniplaces_flats(@flat_preference.location, @flat_preference.country)
    @uniacco_payload = uniacco_flats(@flat_preference.location)
    @flatshare_payload = flatshare_flats(@flat_preference.location, @flat_preference.country)
    @uniacco_flats = @uniacco_payload[:flats]
    @uniplaces_flats = @uniplaces_payload[:flats]
    @flatshare_flats = @flatshare_payload[:flats]
    @upscale_flats = []
    return if (@uniacco_flats + @uniplaces_flats + @upscale_flats + @flatshare_flats).present?

    flash[:alert] = 'Please type another location'
    redirect_to real_estate_path
  end

  def uniplaces_flats(location, country)
    UniplacesApiService.new(city_code: location, country: country, flat_preference_id: current_user.flat_preference.id, page: 1, flat_types: 'entire-place').flats
  end

  def flatshare_flats(location, country)
    UniplacesApiService.new(city_code: location, country: country, flat_preference_id: current_user.flat_preference.id, page: 1, flat_types: 'private-bedroom,shared-bedroom').flats
  end

  def uniacco_flats(location)
    UniaccoApiService.new(city_code: location, flat_preference_id: current_user.flat_preference.id).flats
  end

  def clear_filters
    current_user.flat_preference.update(range_min_price: nil, range_max_price: nil, facilities: [], flat_type: nil, recommandations: [])
  end
end
