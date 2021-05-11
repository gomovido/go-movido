class FlatsController < ApplicationController
  before_action :set_browser
  def index
    @flat_preference = current_user.flat_preference
    unless @flat_preference
      redirect_to real_estate_path
      return
    end
    @move_in = @flat_preference.move_in.strftime
    @move_out = @flat_preference.move_out.strftime
    @location = @flat_preference.location
    @type = @flat_preference.flat_type
    @start_min_price = 5000
    @start_max_price = 200_000
    @range_min_price = @flat_preference.min_price
    @range_max_price = @flat_preference.max_price
    @center = [@flat_preference.coordinates[1], @flat_preference.coordinates[0]]
    fetch_flats(@flat_preference, @type)
    respond_to do |format|
      format.html
      format.json do
        render json: { entries: render_to_string(partial: "flats/#{device}/index/flats", formats: [:html], locals: { flats: @flats, location: @location, type: @flat_preference.flat_type }), pagination: view_context.pagy_nav(@pagy), markers: @markers }
      end
    end
  end

  def fetch_flats(preferences, type)
    page = params[:page] || 1
    case type
    when 'entire_flat', 'flatshare'
      flat_types = type == 'entire_flat' ? 'entire-place' : 'shared-bedroom,private-bedroom'
      response = UniplacesApiService.new(city_code: preferences.location, country: preferences.country, page: page, flat_preference_id: preferences.id, flat_types: flat_types).flats
      page = 1 if response[:count].to_i.zero?
      @pagy = Pagy.new(count: response[:count], page: page, location: preferences.location, type: preferences.flat_type)
      @markers = response[:markers]
    when 'student_housing'
      response = UniaccoApiService.new(flat_preference_id: preferences.id, page: page).filtered_flats
      page = 1 if response[:count].to_i.zero?
      @pagy = Pagy.new(count: response[:count], page: page, items: 15, location: preferences.location, type: preferences.flat_type)
      @markers = response[:markers]
    end

    preferences.update(recommandations: response[:recommandations])
    @flats = response[:flats]
  end

  def clear_filters
    current_user.flat_preference.update(range_min_price: nil, range_max_price: nil, facilities: [], move_in: Time.zone.today, move_out: Time.zone.today + 30.days)
    redirect_to flats_path(current_user.flat_preference.location, current_user.flat_preference.flat_type)
  end

  def show
    unless current_user.flat_preference
      redirect_to real_estate_path
      return
    end
    @location = params[:location]
    @type = params[:type]
    @code = params[:code]
    current_user.flat_preference.update(flat_type: @type)
    @flat_id = params[:flat_id]
    case @type
    when 'student_housing'
      response = UniaccoApiService.new(code: @code, location: @location, country: current_user.flat_preference.country, flat_preference_id: current_user.flat_preference.id).flat
      @flat = response[:payload] if response[:status] == 200
    when 'entire_flat', 'flatshare'
      response = UniplacesApiService.new(property_code: @code, flat_preference_id: current_user.flat_preference.id).flat
      @flat = response[:flat] if response[:status] == 200
    end
    if @flat
      @recommandations = current_user.flat_preference.recommandations.filter_map { |flat| JSON.parse(flat) if JSON.parse(flat)['code'] != @flat[:code] }
      @markers = response[:markers]
      @center = [current_user.flat_preference.coordinates[1], current_user.flat_preference.coordinates[0]]
      @flat = AggregatorApiService.new(flat: @flat, type: @type).format_flat
    else
      flash[:alert] = 'An error has occured'
      redirect_to flats_path(@location, @type)
    end
  end

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end
end
