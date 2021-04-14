class UniplacesApiService
  def initialize(params)
    @location = params[:city_code]
    @country = params[:country]
    @page = params[:page]
    @code = params[:property_code]
    @flat_preference_id = params[:flat_preference_id]
  end

  def flats
    flat_preference = FlatPreference.find(@flat_preference_id)
    move_in = flat_preference.move_in.strftime('%Y-%m-%d')
    move_out = flat_preference.move_out.strftime('%Y-%m-%d')
    uri = URI("https://api.staging-uniplaces.com/v1/offers/#{@country.upcase}-#{@location}?move-in=#{move_in}&move-out=#{move_out}&page=#{@page}")
    response = HTTParty.get(uri, headers: { "X-Api-Key" => set_api_key, "Content-Type" => "application/json" })
    if response['data'].present?
      {
        error: nil,
        status: 200,
        flats: response['data'],
        recommandations: recommandations(response['data']),
        total_pages: response['meta']['total_page_number'],
        count: response['meta']['total_found']
      }
    else
      {
        error: 'NOT_FOUND',
        status: 404,
        flats: [],
        recommandations: [],
        total_pages: 0,
        count: 0
      }
    end
  end

  def flat
    uri = URI("https://api.staging-uniplaces.com/v1/offer/#{@code}")
    response = HTTParty.get(uri, headers: { "X-Api-Key" => set_api_key, "Content-Type" => "application/json" })
    payload = response
    return unless payload

    {
      error: nil,
      status: 200,
      flat: payload,
      total_pages: 1
    }
  end

  def recommandations(payload)
    payload.first(12).map do |flat|
      {
        code: flat['id'],
        image: "https://cdn-static.staging-uniplaces.com/property-photos/#{flat['attributes']['photos'][0]['hash']}/medium.jpg",
        price: flat['attributes']['accommodation_offer']['price']['amount'] / 100,
        billing: flat['attributes']['accommodation_offer']['contract_type'],
        currency: flat['attributes']['accommodation_offer']['price']['currency_code'],
        name: flat['attributes']['accommodation_offer']['title']
      }.to_json
    end
  end

  def set_api_key
    Rails.env.production? ? Rails.application.credentials.production[:uniplaces][:api_key] : Rails.application.credentials.staging[:uniplaces][:api_key]
  end
end
