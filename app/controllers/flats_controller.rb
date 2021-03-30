class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[landing search]
  def landing
    Rails.cache.clear
  end

  def index
    @active_filters = JSON.parse(Rails.cache.read(:filters)) if Rails.cache.read(:filters)
    @start_date = Rails.cache.read(:start_date) || Time.zone.now.to_date.strftime
    @location = params[:location]
    @type = params[:type]
    properties_codes = Rails.cache.read(:codes)
    if properties_codes
      @pagy, properties = pagy_array(properties_codes.split(','))
      response = UniaccoApiService.new(properties: properties, location: params[:location], active_filters: @active_filters, start_date: @start_date).avanced_list_flats
      if response[:status] == 200
        @flats = response[:flats]
        @other_flats = response[:recommandations]
        Rails.cache.write(:recommandations, @other_flats.to_json, expires_in: 30.minutes)
        respond_to do |format|
          format.html
          format.json do
            render json: { entries: render_to_string(partial: "flats/mobile/flats", formats: [:html], locals: { flats: @flats, location: @location, type: @type }), pagination: view_context.pagy_nav(@pagy) }
          end
        end
      end
    else
      redirect_to real_estate_landing_path
      flash[:alert] = 'Your request has expired'
    end
  end

  def clear_filters
    Rails.cache.delete(:filters)
    redirect_to flats_path(params[:location], params[:type])
  end

  def show
    @location = params[:location]
    @type = params[:type]
    @code = params[:code]
    @flat = UniaccoApiService.new(property_code: @code, location: params[:location]).flat
    @flat = @flat[:payload] if @flat[:status] == 200
    @recommandations = JSON.parse(Rails.cache.read(:recommandations)).filter { |reco| reco['code'] != @flat[:code] } if Rails.cache.read(:recommandations)
  end

  def search
    location = format_params(params[:location])
    city_code = UniaccoApiService.new(location: location).check_and_return_city_code
    if city_code
      redirect_to providers_path(query: city_code)
    else
      Rails.cache.clear
      flash[:alert] = 'Please type another location'
      redirect_to real_estate_landing_path
    end
  end

  private

  def format_params(location)
    location.split(',').map { |string| string.strip.downcase.tr(' ', '-') }
  end
end
