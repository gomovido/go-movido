class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    Rails.cache.clear
    @uniacco_flats = UniaccoApiService.new(city_code: params[:query]).list_flats
    if @uniacco_flats[:status] == 200
      caching_properties(@uniacco_flats)
      @type = params[:type]
      @uniacco_flats = @uniacco_flats[:payload]
    else
      @uniacco_flats = []
    end
    @homelike_flats = []
    @uniplaces_flats = []
    @flats = @homelike_flats + @uniplaces_flats + @uniacco_flats
    redirect_to real_estate_landing_path if @flats.flatten.blank?
  end

  def caching_properties(payload)
    Rails.cache.write(:price_range, {min_price: payload[:min_price], max_price: payload[:max_price]}.to_json, expires_in: 30.minutes)
    Rails.cache.write(:codes, payload[:codes], expires_in: 30.minutes)
    Rails.cache.write(:recommandations, payload[:recommandations].to_json, expires_in: 30.minutes)
  end
end
