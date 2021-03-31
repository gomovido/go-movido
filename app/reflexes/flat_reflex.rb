class FlatReflex < ApplicationReflex
  delegate :view_context, to: :controller
  delegate :current_user, to: :connection
  before_reflex :set_browser
  include Pagy::Backend

  def filter(date)
    @flat_preference = current_user.flat_preference
    @flat_preference.start_date = date.split[0].to_date
    @flat_preference.assign_attributes(flat_preference_params)
    @flat_preference.save
    properties_codes = @flat_preference.codes
    @pagy, properties = pagy_array(properties_codes)
    response = UniaccoApiService.new(properties: properties, flat_preference_id: @flat_preference.id).avanced_list_flats
    return if response[:status] != 200

    @flats = response[:flats]
    @other_flats = response[:recommandations]
    @flat_preference.update(recommandations: @other_flats)
    morph ".flats-card-wrapper", render(partial: "flats/#{device}/flats", locals: { flats: @flats, location: @flat_preference.location, type: @flat_preference.flat_type }, pagination: view_context.pagy_nav(@pagy))
    morph ".clear-filters", render(partial: "flats/#{device}/clear_filters", locals: { active_filters: @flat_preference.active?, location: @flat_preference.location, type: @flat_preference.flat_type })
  end

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end

  def flat_preference_params
    params.require(:flat_preference).permit(:microwave, :dishwasher, :start_date, :range_min_price, :range_max_price)
  end
end
