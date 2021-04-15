class FlatReflex < ApplicationReflex
  delegate :view_context, to: :controller
  delegate :current_user, to: :connection
  before_reflex :set_browser
  include Pagy::Backend

  def filter(date)
    @flat_preference = current_user.flat_preference
    @flat_preference.facilities = params["flat_preference"].to_unsafe_h.map { |facility, value| facility.tr('_','-') if value == "1" }.compact
    @flat_preference.move_in = date.split[0].to_date
    @flat_preference.move_out = date.split[-1].to_date
    @flat_preference.range_min_price = params["flat_preference"]["range_min_price"].to_i * 100
    @flat_preference.range_max_price = params["flat_preference"]["range_max_price"].to_i * 100
    @flat_preference.save
    fetch_flats(@flat_preference, @flat_preference.flat_type)
    morph ".flats-card-wrapper", render(partial: "flats/#{device}/flats", locals: { flats: @flats, location: @flat_preference.location, type: @flat_preference.flat_type }, pagination: view_context.pagy_nav(@pagy))
    morph ".clear-filters", render(partial: "flats/#{device}/clear_filters", locals: { active_filters: @flat_preference.facilities.present?, location: @flat_preference.location, type: @flat_preference.flat_type })
    morph ".no-results", render(partial: "flats/#{device}/no_results", locals: { flats: @flats, location: @flat_preference.location, type: @flat_preference.flat_type })
    morph ".pagy", render(partial: "flats/#{device}/pagy", locals: { pagy: @pagy })
  end

  def fetch_flats(preferences, type)
    case type
    when 'entire_flat'
      response = UniplacesApiService.new(city_code: preferences.location, country: preferences.country, page: 1, flat_preference_id: preferences.id).flats
      @pagy = Pagy.new(count: response[:count], page: 1, location: preferences.location, type: preferences.flat_type)
    when 'student_housing'
      response = UniaccoApiService.new(flat_preference_id: preferences.id, page: 1).filtered_flats
      @pagy = Pagy.new(count: response[:count], page: 1, items: 15, location: preferences.location, type: preferences.flat_type)
    end

    preferences.update(recommandations: response[:recommandations])
    @flats = response[:flats]
  end

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end

  def flat_preference_params
    params.require(:flat_preference).permit(:range_min_price, :range_max_price, :flat_type)
  end
end
