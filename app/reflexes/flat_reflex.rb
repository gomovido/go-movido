class FlatReflex < ApplicationReflex
  delegate :view_context, to: :controller
  before_reflex :set_browser
  include Pagy::Backend

  def filter(date)
    if !params['filters'] && Rails.cache.read(:filters)
      @active_filters = JSON.parse(Rails.cache.read(:filters))
    else
      @active_filters = {}
      params['filters']&.each do |k, v|
        @active_filters[k] = v if v != "0"
      end
    end
    @active_filters['min'] = JSON.parse(Rails.cache.read(:price_range))["min_price"] unless @active_filters['min']
    @active_filters['max'] = JSON.parse(Rails.cache.read(:price_range))["max_price"] unless @active_filters['max']
    @location = params['location']
    @type = params['type']
    start_date = date.split[0]
    properties_codes = Rails.cache.read(:codes)
    @pagy, properties = pagy_array(properties_codes.split(','))
    response = UniaccoApiService.new(properties: properties, location: @location, active_filters: @active_filters, start_date: start_date).avanced_list_flats
    return if response[:status] != 200

    @flats = response[:flats]
    @other_flats = response[:recommandations]
    Rails.cache.write(:recommandations, @other_flats.to_json, expires_in: 30.minutes)
    Rails.cache.write(:start_date, start_date, expires_in: 30.minutes)
    morph ".flats-card-wrapper", render(partial: "flats/#{device}/flats", locals: { flats: @flats, location: @location, type: @type }, pagination: view_context.pagy_nav(@pagy))
    return if @active_filters.blank?

    morph ".clear-filters", render(partial: "flats/#{device}/clear_filters", locals: { active_filters: @active_filters, location: @location, type: @type })
    Rails.cache.write(:filters, @active_filters.to_json, expires_in: 30.minutes)
  end

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end
end
