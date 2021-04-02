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
    @codes = @flat_preference.codes
    @pagy, properties = pagy_array(@codes)
    response = UniaccoApiService.new(properties: properties, flat_preference_id: @flat_preference.id).avanced_list_flats
    return unless response[:status] == 200

    @flats = response[:flats]
    @flat_preference.update(recommandations: response[:recommandations])
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
    @flat = UniaccoApiService.new(property_code: @code, location: @location).flat
    @flat = @flat[:payload] if @flat[:status] == 200
    @recommandations = current_user.flat_preference.recommandations.filter_map { |flat| JSON.parse(flat) if JSON.parse(flat)['code'] != @flat[:code] }
  end
end
