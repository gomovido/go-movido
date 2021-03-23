class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    @uniacco_flats = UniaccoApiService.new(city_code: params[:query]).list_flats
    if @uniacco_flats[:status] == 200
      @type = params[:type]
      @uniacco_flats = @uniacco_flats[:payload]
      @other_flats = @uniacco_flats.first(5).map { |flat| { code: flat['code'], image: flat['images'][0]['url'], price: flat['disp_price'], billing: flat['billing'], name: flat['name'] } }
      Rails.cache.write(:codes, @uniacco_flats.map { |flat| flat['code'] }.join(','), expires_in: 30.minutes)
      Rails.cache.write(:recommandations, @other_flats.to_json, expires_in: 30.minutes)
    else
      @uniacco_flats = []
    end
    @homelike_flats = []
    @uniplaces_flats = []
    @flats = @homelike_flats + @uniplaces_flats + @uniacco_flats
    redirect_to real_estate_landing_path if @flats.flatten.blank?
  end
end
