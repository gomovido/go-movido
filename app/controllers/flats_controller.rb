class FlatsController < ApplicationController
  def landing
  end

  def index
    @flats = HousingApiService.new(country_code: params[:country], city: params[:city]).list_flats
  end

  def search
    country = params[:query][:country].downcase.gsub(' ', '-')
    city = params[:query][:city].downcase.gsub(' ', '-')
    redirect_to flats_path(country, city)
  end
end
