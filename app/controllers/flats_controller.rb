class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[landing search index listing]
  def landing
  end

  def index
    @location = params[:location]
    @type = params[:type]
    @pagy, properties = pagy_array(Rails.cache.read(:codes).split(','))
    @flats = UniaccoApiService.new(properties: properties, location: params[:location]).avanced_list_flats
    if @flats[:status] == 200
      @flats = @flats[:payload]
      respond_to do |format|
        format.html
        format.json {
          render json: { entries: render_to_string(partial: "flats/mobile/flats", formats: [:html]), pagination: view_context.pagy_nav(@pagy) }
        }
      end
    end
  end
    
  def show
    @location = params[:location]
    @type = params[:type]
    @code = params[:code]
    @flat = UniaccoApiService.new(property_code: @code, location: params[:location]).flat
    @flat = @flat[:payload] if @flat[:status] == 200
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
