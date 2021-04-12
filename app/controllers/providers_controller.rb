class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    @flat_preference = current_user.flat_preference
    @uniplaces_payload = uniplaces_flats(@flat_preference.location, @flat_preference.country)
    @uniacco_payload = uniacco_flats(@flat_preference.location)
    @flats = @uniacco_payload[:flats] + @uniplaces_payload[:flats]
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
end
