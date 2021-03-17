class ProvidersController < ApplicationController
  def index
    @uniacco_flats = UniaccoApiService.new(city_code: params[:query]).list_flats
    if @uniacco_flats[:status] == 200
      @uniacco_flats = @uniacco_flats[:payload]
      Rails.cache.write(:codes, @uniacco_flats.map { |flat| flat['code'] }.join(','), expires_in: 30.minutes)
    else
      @uniacco_flats = []
    end
    @homelike_flats = []
    @uniplaces_flats = []
    @flats = @homelike_flats + @uniplaces_flats + @uniacco_flats
    redirect_to real_estate_landing_path if @flats.flatten.blank?
  end
end
