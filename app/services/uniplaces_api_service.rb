class UniplacesApiService
  def initialize(params)
    @location = params[:city_code]
    @country = params[:country]
    @page = params[:page]
    @code = params[:property_code]
    @flat_preference_id = params[:flat_preference_id]
  end

  def list_flats
    flat_preference = FlatPreference.find(@flat_preference_id)
    move_in = flat_preference.move_in.strftime('%Y-%m-%d')
    move_out = flat_preference.move_out.strftime('%Y-%m-%d')
    uri = URI("https://api.staging-uniplaces.com/v1/offers/#{@country.upcase}-#{@location}?move-in=#{move_in}&move-out=#{move_out}&page=#{@page}")
    response = HTTParty.get(uri, headers: { "X-Api-Key" => (ENV['UNIPLACES_API_KEY']).to_s, "Content-Type" => "application/json" })
    payload = response['data']
    return unless payload

    {
      error: nil,
      status: 200,
      flats: payload,
      recommandations: [],
      codes: [],
      total_pages: response['meta']['total_page_number']
    }
  end

  def list_flat
    uri = URI("https://api.staging-uniplaces.com/v1/offer/#{@code}")
    response = HTTParty.get(uri, headers: { "X-Api-Key" => (ENV['UNIPLACES_API_KEY']).to_s, "Content-Type" => "application/json" })
    payload = response
    return unless payload

    {
      error: nil,
      status: 200,
      flat: payload,
      recommandations: [],
      codes: [],
      total_pages: 1
    }
  end
end
