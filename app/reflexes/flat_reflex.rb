class FlatReflex < ApplicationReflex
  before_reflex :set_browser
  include Pagy::Backend
  # rubocop:disable Lint/AmbiguousBlockAssociation
  def filter_by_dates
    @location = params['location']
    @type = params['type']
    value = element.value.split(' ')
    if value.length == 3
      start_date = value[0].to_date
      end_date = value[-1].to_date
      @pagy, properties = pagy_array(Rails.cache.read(:codes).split(','))
      @flats = UniaccoApiService.new(properties: properties, location: params[:location]).avanced_list_flats
      if @flats[:status] == 200
        @flats = @flats[:payload].filter do |flat|
          flat[:details]['configs'][0]['subconfigs'][0]['available_from'].to_date >= start_date
        end
        @other_flats = @flats.first(4).map {|flat| {code: flat[:code], image: flat[:images][0]['url'], price: flat[:details]['disp_price'], billing: flat[:details]['billing'], name: flat[:details]['name'] }}
        Rails.cache.write(:recommandations, @other_flats.to_json, expires_in: 30.minutes)
        morph ".flats-card-wrapper", with_locale { render(partial: "flats/#{@browser.device.mobile? ? 'mobile' : 'desktop'}/flats", locals: { flats: @flats, location: @location, type: @type}) }
        Rails.cache.write(:start_date, start_date.strftime, expires_in: 30.minutes)
      end
    end
  end

  # rubocop:enable Lint/AmbiguousBlockAssociation

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end
end
