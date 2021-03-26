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
      @flats = UniaccoApiService.new(properties: properties, location: params[:location]).avanced_list_flats
      if @flats[:status] == 200

        @flats = filters(@flats[:payload], @active_filters, @start_date.to_date)
        @other_flats = @flats.first(4).map { |flat| { code: flat[:code], image: flat[:images][0]['url'], price: flat[:details]['disp_price'], billing: flat[:details]['billing'], name: flat[:details]['name'] } }
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

  def filters(flats, filters_list, start_date)
    flats.filter do |flat|
      availability_date = flat[:details]['configs'][0]['subconfigs'][0]['available_from'].to_date
      if filters_list.present?
        facilities = flat[:apartment_facilities].map { |facility| facility['kind'] }
        flat if (filters_list - facilities).empty? && availability_date <= start_date
      elsif availability_date <= start_date
        flat
      end
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
      flash[:alert] = 'Please type another location'
      render :landing
    end
  end

  private

  def format_params(location)
    location.split(',').map { |string| string.strip.downcase.tr(' ', '-') }
  end
end
