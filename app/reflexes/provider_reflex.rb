class ProviderReflex < ApplicationReflex
  delegate :view_context, to: :controller
  delegate :current_user, to: :connection
  before_reflex :set_browser
  include Pagy::Backend

  def filter(date)
    @flat_preference = current_user.flat_preference
    @flat_preference.move_in = date.split[0].to_date
    @flat_preference.move_out = date.split[-1].to_date
    @flat_preference.save
    @uniplaces_payload = uniplaces_flats(@flat_preference.location, @flat_preference.country)
    @uniacco_payload = uniacco_flats(@flat_preference.location)
    @uniacco_flats = @uniacco_payload[:flats]
    @uniplaces_flats = @uniplaces_payload[:flats]
    @flatshare_flats = []
    @upscale_flats = []
    @count = @uniacco_payload[:count] + @uniplaces_payload[:count]
    morph ".providers-wrapper",
          render(partial: "providers/#{device}/categories",
                 locals: {
                   uniacco_flats: @uniacco_flats,
                   uniplaces_flats: @uniplaces_flats,
                   upscale_flats: @upscale_flats,
                   flatshare_flats: @flatshare_flats
                 })
    morph ".count-results",
          render(partial: "providers/#{device}/count",
                 locals: { count: @count })
  end

  def uniplaces_flats(location, country)
    UniplacesApiService.new(city_code: location, country: country, flat_preference_id: current_user.flat_preference.id, page: 1).flats
  end

  def uniacco_flats(location)
    UniaccoApiService.new(city_code: location, flat_preference_id: current_user.flat_preference.id).flats
  end

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end
end
