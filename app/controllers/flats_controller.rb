class FlatsController < ApplicationController
  def index
    @flat_preference = current_user.flat_preference
    @move_in = @flat_preference.move_in.strftime
    @move_out = @flat_preference.move_out.strftime
    @location = @flat_preference.location
    @type = @flat_preference.flat_type
    @start_min_price = 50
    @start_max_price = 2000
    @range_min_price = @flat_preference.min_price
    @range_max_price = @flat_preference.max_price
    if @type == 'entire_flat'
      uniplaces_payload = uniplaces_flats(@flat_preference)
      @flats = uniplaces_payload[:flats]
    elsif @type == 'student_housing'
      uniacco_payload = uniacco_flats(@flat_preference)
      @flats = uniacco_payload[:flats]
    end
    respond_to do |format|
      format.html
      format.json do
        render json: { entries: render_to_string(partial: "flats/mobile/flats", formats: [:html], locals: { flats: @flats, location: @location, type: @flat_preference.flat_type }), pagination: view_context.pagy_nav(@pagy) }
      end
    end
  end

  def uniacco_flats(preferences)
    @pagy, properties = pagy_array(preferences.codes)
    response = UniaccoApiService.new(properties: properties, flat_preference_id: preferences.id).avanced_list_flats
    return unless response[:status] == 200
    preferences.update(recommandations: response[:recommandations])
    response
  end

  def uniplaces_flats(preferences)
    page = params[:page]
    response = UniplacesApiService.new(city_code: preferences.location, country: preferences.country, page: page, flat_preference_id: preferences.id).list_flats
    page = 1 if response[:total_pages].to_i.zero?
    @pagy = Pagy.new(count: response[:total_pages], page: page)
    preferences.update(recommandations: response[:recommandations])
    return unless response[:status] == 200
    response
  end

  def clear_filters
    current_user.flat_preference.update(range_min_price: nil, range_max_price: nil, microwave: false, dishwasher: false, move_in: Time.zone.today, move_out: Time.zone.today + 30.days)
    redirect_to flats_path(current_user.flat_preference.location, current_user.flat_preference.flat_type)
  end

  def show
    @location = params[:location]
    @type = params[:type]
    @code = params[:code]
    current_user.flat_preference.update(flat_type: @type)
    @flat_id = params[:flat_id]
    if @type == 'student_housing'
      @flat = UniaccoApiService.new(property_code: @code, location: @location, country: current_user.flat_preference.country).flat
      @flat = @flat[:payload] if @flat[:status] == 200
      @recommandations = current_user.flat_preference.recommandations.filter_map { |flat| JSON.parse(flat) if JSON.parse(flat)['code'] != @flat[:code] }
    elsif @type == 'entire_flat'
      @flat = UniplacesApiService.new(property_code: @code).list_flat
      @flat = @flat[:flat] if @flat[:status] == 200
      @recommandations = current_user.flat_preference.recommandations.filter_map { |flat| JSON.parse(flat) if JSON.parse(flat)['code'] != @flat['id'] }
    end
    @flat = AggregatorApiService.new(flat: @flat, type: @type).format_flat
  end
end
