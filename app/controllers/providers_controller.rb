class ProvidersController < ApplicationController
  def index
    @flats = UniaccoApiService.new(city_code: params[:query]).list_flats
  end
end
