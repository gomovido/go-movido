class FlatsController < ApplicationController
  def landing
  end

  def index

  end

  def search
    @country = params[:query][:country].downcase.gsub(' ', '-')
    @city = params[:query][:city].downcase.gsub(' ', '-')
    @flats = HousingApiService.new(country_code: 'uk', city: 'london').list_flats
    render :index
  end
end
