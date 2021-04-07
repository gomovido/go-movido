class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    @flat_preference = current_user.flat_preference
    @uniplaces_payload = uniplaces_flats(@flat_preference.location, @flat_preference.country)
    @uniacco_payload = uniacco_flats(@flat_preference.location)
    @flats = @uniacco_payload[:flats] + @uniplaces_payload[:flats] if update_preferences(@uniplaces_payload, @uniacco_payload, @flat_preference)
    unless @flats or !@flats.blank?
      flash[:alert] = 'Please type another location'
      redirect_to real_estate_path
    end
  end

  def uniplaces_flats(location, country)
    payload = UniplacesApiService.new(city_code: location, country: country).list_flats
    return unless payload[:status] == 200
    payload
  end

  def uniacco_flats(location)
    payload = UniaccoApiService.new(city_code: location).list_flats
    return unless payload[:status] == 200 && current_user.flat_preference.update(codes: payload[:codes])
    payload
  end

  def update_preferences(uniplaces_payload, uniacco_payload, preferences)
    min_price = [uniplaces_payload[:max_price], uniplaces_payload[:min_price], uniacco_payload[:max_price], uniacco_payload[:max_price]].min
    max_price = [uniplaces_payload[:max_price], uniplaces_payload[:min_price], uniacco_payload[:max_price], uniacco_payload[:max_price]].max
    preferences.update(start_min_price: min_price, start_max_price: max_price)
  end


end
