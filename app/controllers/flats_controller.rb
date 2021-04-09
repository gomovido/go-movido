class FlatsController < ApplicationController
  def index
    @flat_preference = current_user.flat_preference
    @flat_preference.update(flat_type: params[:type]) if params[:type] != @flat_preference.flat_type
    @start_date = @flat_preference.start_date.strftime
    @location = @flat_preference.location
    @type = @flat_preference.flat_type
    @start_min_price = @flat_preference.start_min_price
    @start_max_price = @flat_preference.start_max_price
    @range_min_price = @flat_preference.min_price
    @range_max_price = @flat_preference.max_price
    if @type == 'entire_flat'
      uniplaces_payload = uniplaces_flats(@flat_preference)
      @flats = uniplaces_payload[:flats] if update_preferences(uniplaces_payload, @flat_preference)
    elsif @type == 'student_housing'
      uniacco_payload = uniacco_flats(@flat_preference)
      @flats = uniacco_payload[:flats] if update_preferences(uniacco_payload, @flat_preference)
    end
    respond_to do |format|
      format.html
      format.json do
        render json: { entries: render_to_string(partial: "flats/mobile/flats", formats: [:html], locals: { flats: @flats, location: @location, type: @type }), pagination: view_context.pagy_nav(@pagy) }
      end
    end
  end

  def clear_filters
    current_user.flat_preference.update(range_min_price: nil, range_max_price: nil, microwave: false, dishwasher: false, start_date: Time.zone.today)
    redirect_to flats_path(current_user.flat_preference.location, current_user.flat_preference.flat_type)
  end

  def show
    @location = params[:location]
    @type = params[:type]
    @code = params[:code]
    @flat_id = params[:flat_id]
    if @type == 'student_housing'
      @flat = UniaccoApiService.new(property_code: @code, location: @location, country: current_user.flat_preference.country).flat
      @flat = @flat[:payload] if @flat[:status] == 200
      @recommandations = current_user.flat_preference.recommandations.filter_map { |flat| JSON.parse(flat) if JSON.parse(flat)['code'] != @flat[:code] }
    elsif @type == 'entire_flat'
      @flat = UniplacesApiService.new(property_code: @code).list_flat
      @flat = @flat[:flat] if @flat[:status] == 200
    end
  end


  def uniacco_flats(preferences)
    @pagy, properties = pagy_array(preferences.codes)
    payload = UniaccoApiService.new(properties: properties, flat_preference_id: preferences.id).avanced_list_flats
    return unless payload[:status] == 200
    preferences.update(recommandations: payload[:recommandations])
    payload
  end

  def uniplaces_flats(preferences)
    payload = UniplacesApiService.new(city_code: preferences.location, country: preferences.country, page: params[:page]).list_flats
    @pagy = Pagy.new(count: payload[:total_pages], page: params[:page])
    return unless payload[:status] == 200
    payload
  end

  def update_preferences(payload, preferences)
    preferences.update(start_min_price: payload[:min_price], start_max_price: payload[:max_price])
  end

end
