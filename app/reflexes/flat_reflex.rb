class FlatReflex < ApplicationReflex
  delegate :view_context, to: :controller
  before_reflex :set_browser
  include Pagy::Backend

  def filter(date)
    if Rails.cache.read(:filters)
      @active_filters = JSON.parse(Rails.cache.read(:filters))
    else
      @active_filters = []
      params['filters']&.each { |k, v| @active_filters << k if v == "1" }
    end
    @location = params['location']
    @type = params['type']
    start_date = date.split[0].to_date
    properties_codes = Rails.cache.read(:codes)
    @pagy, properties = pagy_array(properties_codes.split(','))
    @flats = UniaccoApiService.new(properties: properties, location: @location).avanced_list_flats
    return unless @flats[:status] == 200

    @flats = filters(@flats[:payload], @active_filters, start_date)
    @other_flats = @flats.first(4).map { |flat| { code: flat[:code], image: flat[:images][0]['url'], price: flat[:details]['disp_price'], billing: flat[:details]['billing'], name: flat[:details]['name'] } }
    Rails.cache.write(:recommandations, @other_flats.to_json, expires_in: 30.minutes)
    morph ".flats-card-wrapper", render(partial: "flats/#{@browser.device.mobile? ? 'mobile' : 'desktop'}/flats", locals: { flats: @flats, location: @location, type: @type }, pagination: view_context.pagy_nav(@pagy))
    morph ".clear-filters", render(partial: "flats/#{@browser.device.mobile? ? 'mobile' : 'desktop'}/clear_filters", locals: { active_filters: @active_filters, location: @location, type: @type }) if @active_filters.present?
    Rails.cache.write(:start_date, start_date.strftime, expires_in: 30.minutes)
    Rails.cache.write(:filters, @active_filters.to_json, expires_in: 30.minutes) if @active_filters.present?
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

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end
end
