class FlatReflex < ApplicationReflex
  delegate :view_context, to: :controller
  before_reflex :set_browser
  include Pagy::Backend
  def filter(element, date)
    p "THIS IS ELEMENT IN FILTER REFLEX"
    p element
    @location = params['location']
    @type = params['type']
    value = element.value.split
    start_date = value[0].to_date
    filters_list = params['filters']
    properties_codes = Rails.cache.read(:codes)
    @pagy, properties = pagy_array(properties_codes.split(','))
    @flats = UniaccoApiService.new(properties: properties, location: params[:location]).avanced_list_flats
    return unless @flats[:status] == 200
    @flats = @flats[:payload].filter do |flat|
      flat[:details]['configs'][0]['subconfigs'][0]['available_from'].to_date <= start_date
    end
    p filters_list
    @flats = filters(@flats, filters_list) if filters_list
    @other_flats = @flats.first(4).map { |flat| { code: flat[:code], image: flat[:images][0]['url'], price: flat[:details]['disp_price'], billing: flat[:details]['billing'], name: flat[:details]['name'] } }
    Rails.cache.write(:recommandations, @other_flats.to_json, expires_in: 30.minutes)
    morph ".flats-card-wrapper", render(partial: "flats/#{@browser.device.mobile? ? 'mobile' : 'desktop'}/flats", locals: { flats: @flats, location: @location, type: @type }, pagination: view_context.pagy_nav(@pagy))
    Rails.cache.write(:start_date, start_date.strftime, expires_in: 30.minutes)
  end

  def filters(flats, filters_list)
    filters_active = filters_list.filter{|k, v| v == 1}.map{|f| f}.sort
    @flats = @flats[:payload].filter do |flat|
      facilities = flat[:apartment_facilities].map{| facility| facility['kind']}.sort
      flat if facilities.include?(filters_active)
    end
    return @flats
  end


  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end
end
