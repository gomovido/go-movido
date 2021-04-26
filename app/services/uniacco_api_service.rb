class UniaccoApiService
  def initialize(params)
    @city_code = params[:city_code]
    @flat_preference_id = params[:flat_preference_id]
    @page = params[:page]
    @location = params[:location]
    @code = params[:code]
  end

  def flats
    flat_preference = FlatPreference.find(@flat_preference_id)
    query = {
      'move_in' => flat_preference.move_in.strftime('%m-%Y'),
      'price_min' => flat_preference.min_price / 100,
      'price_max' => flat_preference.max_price / 100
    }
    query['facilities'] = flat_preference.facilities.join(',') if flat_preference.facilities.present?
    uri = URI("https://uniacco.com/api/v1/cities/#{@city_code}/properties?sortBy=relevance")
    response = HTTParty.get(uri, headers: { "Content-Type" => "application/json" }, query: query)
    format_response(response, @flat_preference_id)
  end

  def recommandations(properties)
    properties.first(7).map do |flat|
      {
        code: flat['code'],
        image: flat['images'][0]['url'],
        price: flat['disp_price'],
        billing: flat['billing'],
        name: flat['name']
      }.to_json
    end
  end

  def filtered_flats
    flat_preference = FlatPreference.find(@flat_preference_id)
    query = {
      'move_in' => flat_preference.move_in.strftime('%m-%Y'),
      'price_min' => flat_preference.min_price / 100,
      'price_max' => flat_preference.max_price / 100
    }
    query['facilities'] = flat_preference.facilities.join(',') if flat_preference.facilities.present?
    uri = URI("https://uniacco.com/api/v1/cities/#{flat_preference.location}/properties?sortBy=relevance&page=#{@page}")
    response = HTTParty.get(uri, headers: { "Content-Type" => "application/json" }, query: query)
    advanced_list_flats(response, format_response(response, @flat_preference_id))
  end

  def advanced_list_flats(response, hash)
    if response && (response['title'] == 'NOT_FOUND')
      {
        error: 'NOT_FOUND',
        status: 404,
        flats: [],
        recommandations: [],
        total_pages: 0,
        count: 0

      }
    elsif response && (response['title'] != 'NOT_FOUND')
      codes = response['properties'].map { |property| property['code'] }.join(',')
      uri = URI("https://uniacco.com/api/v1/configs?properties=#{codes}")
      response = HTTParty.get(uri, headers: { "Content-Type" => "application/json" })
      response["configs"].each do |code, configs|
        flat = hash[:flats].find { |k, _v| k['code'] == code }
        flat["configs"] = configs
        flat["facilities"] = configs.map { |c| c.map { |k, v| k if v == true }.compact }.reject(&:empty?).sort
      end
      return hash

    end
  end

  def format_response(response, flat_preference_id)
    if response && (response['title'] == 'NOT_FOUND')
      {
        error: 'NOT_FOUND',
        status: 404,
        flats: [],
        recommandations: [],
        markers: [],
        total_pages: 0,
        count: 0

      }
    elsif response && (response['title'] != 'NOT_FOUND')
      {
        error: nil,
        status: 200,
        flats: response['properties'],
        recommandations: recommandations(response['properties']),
        markers: set_markers(response['properties'], flat_preference_id),
        total_pages: response['pages'],
        count: response['count']
      }
    end
  end

  def set_markers(payload, flat_preference_id)
    flat_preference = FlatPreference.find(flat_preference_id)
    payload.map do |flat|
      currency = flat['currency']
      currency = flat['rate_unit'].downcase if currency.nil?
      {
        id: flat['code'],
        name: flat['name'],
        price: flat['min_price'],
        frequency: flat['billing'].downcase,
        img: flat['images'][0]['url'],
        currency: currency,
        url: (Rails.application.routes.url_helpers.flat_path(flat_preference.location, flat_preference.flat_type, flat['code']) if flat_preference.flat_type),
        coordinates:
        {
          lng: flat['location']['lng'],
          lat: flat['location']['lat']
        }
      }
    end
  end

  def flat
    flat_preference = FlatPreference.find(@flat_preference_id)
    uri = URI("https://uniacco.com/api/v1/#{flat_preference.country == 'fr' ? 'france' : 'uk'}/#{@location}/#{@code}")
    response = HTTParty.get(uri, headers: { "Content-Type" => "application/json" })
    if response && (response['title'] == 'NOT_FOUND')
      {
        error: 'NOT_FOUND',
        status: 404,
        flats: [],
        recommandations: [],
        total_pages: 0,
        count: 0

      }
    elsif response && (response['title'] != 'NOT_FOUND')
      {
        error: nil,
        status: 200,
        payload: {
          code: response['code'],
          details: response,
          images: response['images'],
          facilities: response['facilities'],
          apartment_facilities: response['apartment_facilities'],
          community_facilities: response['community_facilities']
        },
        markers: set_markers([response], flat_preference.id)
      }
    end
  end
end
