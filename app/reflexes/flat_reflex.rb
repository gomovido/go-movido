class FlatReflex < ApplicationReflex
  delegate :view_context, to: :controller
  delegate :current_user, to: :connection
  before_reflex :set_browser
  include Pagy::Backend

  def filter(date)
    @flat_preference = current_user.flat_preference
    @flat_preference.move_in = date.split[0].to_date
    @flat_preference.move_out = date.split[-1].to_date
    @flat_preference.assign_attributes(flat_preference_params)
    @flat_preference.save
    case @flat_preference.flat_type
    when 'entire_flat'
      uniplaces_payload = uniplaces_flats(@flat_preference)
      @flats = uniplaces_payload[:flats]
    when 'student_housing'
      uniacco_payload = uniacco_flats(@flat_preference)
      @flats = uniacco_payload[:flats]
    end
    morph ".flats-card-wrapper", render(partial: "flats/#{device}/flats", locals: { flats: @flats, location: @flat_preference.location, type: @flat_preference.flat_type }, pagination: view_context.pagy_nav(@pagy))
    morph ".clear-filters", render(partial: "flats/#{device}/clear_filters", locals: { active_filters: @flat_preference.active?, location: @flat_preference.location, type: @flat_preference.flat_type })
    morph ".no-results", render(partial: "flats/#{device}/no_results", locals: { flats: @flats, location: @flat_preference.location, type: @flat_preference.flat_type })
  end

  def uniacco_flats(preferences)
    @pagy, properties = pagy_array(preferences.codes)
    response = UniaccoApiService.new(properties: properties, flat_preference_id: preferences.id).avanced_list_flats
    return unless response[:status] == 200

    preferences.update(recommandations: response[:recommandations])
    return response
  end

  def uniplaces_flats(preferences)
    response = UniplacesApiService.new(city_code: preferences.location, country: preferences.country, page: 1, flat_preference_id: preferences.id).flats
    @pagy = Pagy.new(count: response[:total_pages], page: 1)
    return unless response[:status] == 200

    return response
  end

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end

  def flat_preference_params
    params.require(:flat_preference).permit(:microwave, :dishwasher, :range_min_price, :range_max_price, :flat_type)
  end
end
