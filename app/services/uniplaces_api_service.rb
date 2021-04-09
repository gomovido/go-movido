class UniplacesApiService
  def initialize(params)
    @location = params[:city_code]
    @country = params[:country]
    @page = params[:page]
    @code = params[:property_code]
  end

  def list_flats
    headers = { API_KEY: ENV['UNIPLACES_API_KEY'] }
    uri = URI("https://api.staging-uniplaces.com/v1/offers/#{@country.upcase}-#{@location}?page=#{@page}")
    response = HTTParty.get(uri, :headers => {"X-Api-Key" => "#{ENV['UNIPLACES_API_KEY']}", "Content-Type" => "application/json"})
    payload = response['data']
    prices = get_pricing(payload)
    if payload
      {
        error: nil,
        status: 200,
        flats: payload,
        min_price: 50,
        max_price: 2500,
        recommandations:  [],
        codes: [],
        total_pages: response['meta']['total_page_number']
      }
    end
  end


  def list_flat
    headers = { API_KEY: ENV['UNIPLACES_API_KEY'] }
    uri = URI("https://api.staging-uniplaces.com/v1/offer/#{@code}")
    response = HTTParty.get(uri, :headers => {"X-Api-Key" => "#{ENV['UNIPLACES_API_KEY']}", "Content-Type" => "application/json"})
    payload = response['accommodation_offer']
    if payload
      {
        error: nil,
        status: 200,
        flat: payload,
        min_price: 50,
        max_price: 2500,
        recommandations:  [],
        codes: [],
        total_pages: 1
      }
    end
  end

  def get_pricing(payload)
    pricing_rules = { monthly:  4, fortnight: 2, nightly: 0.7, weekly: 1}
    prices = payload.map do |p|
      price = p['attributes']['accommodation_offer']['price']['amount']
      billing = p['attributes']['accommodation_offer']['contract_type']
      ((price / pricing_rules[billing.to_sym]) / 100).round(0)
    end
  end

end
