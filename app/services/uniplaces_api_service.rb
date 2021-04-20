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
    query = {
      'move-in' => flat_preference.move_in.strftime('%Y-%m-%d'),
      'move-out' => flat_preference.move_out.strftime('%Y-%m-%d'),
      'budget-min' => flat_preference.min_price,
      'budget-max' => flat_preference.max_price
    }
    query['property-features'] = flat_preference.facilities.join(',') if flat_preference.facilities.present?
    uri = URI("https://api.staging-uniplaces.com/v1/offers/#{@country.upcase}-#{@location}?page=#{@page}")
    response = HTTParty.get(uri, headers: { "X-Api-Key" => set_api_key, "Content-Type" => "application/json" }, query: query)
    if response.body.include?("503 Service Temporarily Unavailable") || response['data'].blank?
      {
        error: 'NOT_FOUND',
        status: 404,
        flats: [],
        recommandations: [],
        total_pages: 0,
        count: 0
      }
    else
      {
        error: nil,
        status: 200,
        flats: response['data'],
        recommandations: recommandations(response['data']),
        coordinates: coordinates(response['data']),
        total_pages: response['meta']['total_page_number'],
        count: response['meta']['total_found']
      }
    end
  end

  def flat
    uri = URI("https://api.staging-uniplaces.com/v1/offer/#{@code}")
    response = HTTParty.get(uri, headers: { "X-Api-Key" => set_api_key, "Content-Type" => "application/json" })
    return unless response

    if response && (response["error"]&.upcase&.gsub(' ', '_') == 'OFFER_NOT_FOUND')
      {
        error: 'NOT_FOUND',
        status: 404,
        flats: [],
        recommandations: [],
        total_pages: 0,
        count: 0

      }
    elsif response && (response["error"]&.upcase&.gsub(' ', '_') != 'OFFER_NOT_FOUND')
      {
        error: nil,
        status: 200,
        flat: response
      }
    end
  end

  def coordinates(payload)
    payload.map do |flat|
      {id: flat['id'].to_i, name: flat['attributes']['accommodation_offer']['title'],coordinates: {lng: flat['attributes']['property']['coordinates'][1], lat: flat['attributes']['property']['coordinates'][0]}}
    end
  end

  def recommandations(payload)
    payload.first(7).map do |flat|
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
