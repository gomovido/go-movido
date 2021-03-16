class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[landing search index]
  def landing
  end

  def index
    properties = session[:flats_codes]
    if !properties.blank?
      @flats = UniaccoApiService.new(properties: properties, location: params[:location]).avanced_list_flats
      @flats = @flats[:payload] if @flats[:status] == 200
    end
  end

  def search
    location = format_params(params[:location])
    city_code = UniaccoApiService.new(location: location).check_and_return_city_code
    if city_code
      redirect_to providers_path(query: city_code)
    else
      flash[:alert] = 'Please type another location'
      render :landing
    end
  end

  private

  def format_params(location)
    location.split(',').map { |string| string.strip.downcase.tr(' ', '-') }
  end
end
