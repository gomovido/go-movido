class UniaccoApiService
  def initialize(params)
    @location = params[:location]
    @city_code = params[:city_code]
    @properties = params[:properties]
    @property = params[:property_code]
    @active_filters = params[:active_filters]
    @flat_preference_id = params[:flat_preference_id]
  end

  def list_flats
    uri = URI("https://uniacco.com/api/v1/cities/#{@city_code}/properties?page=1&sortBy=relevance")
    response = JSON.parse(Net::HTTP.get(uri))
    i = 1
    while i < response['pages'].to_i
      i += 1
      uri = URI("https://uniacco.com/api/v1/cities/#{@city_code}/properties?page=#{i}&sortBy=relevance")
      response['properties'] << JSON.parse(Net::HTTP.get(uri))['properties']
    end
    payload = response['properties'].flatten
    min_price = payload.sort_by{|k| k['min_price']}[0]['min_price']
    max_price = payload.sort_by{|k| k['max_price']}[-1]['max_price']
    if response && (response['title'] == 'NOT_FOUND')
      { error: 'NOT_FOUND', status: 404, flats: nil }
    else
      recommandations = payload.first(12).map { |flat| { code: flat['code'], image: flat['images'][0]['url'], price: flat['disp_price'], billing: flat['billing'], name: flat['name'] }.to_json }
      { error: nil, status: 200, flats: payload, min_price: min_price, max_price: max_price, recommandations: recommandations, codes: codes(payload) }
    end
  end

  def avanced_list_flats
    flat_preference = FlatPreference.find(@flat_preference_id)
    array = []
    @properties.map do |property|
      uri = URI("https://uniacco.com/api/v1/uk/#{flat_preference.location}/#{property}")
      response = JSON.parse(Net::HTTP.get(uri))
      array << { code: property, details: response, images: response['images'], facilities: response['facilities'], apartment_facilities: response['apartment_facilities'] } if response && (response['title'] != 'NOT_FOUND')
    end
    return if array.blank?

    response = { error: nil, status: 200, payload: array }
    flats = filters(response[:payload], @flat_preference_id)
    { error: nil, status: 200, flats: flats, recommandations: recommandations(flats) }
  end

  def filters(flats, flat_preference_id)
    flat_preference = FlatPreference.find(flat_preference_id)
    start_date = flat_preference.start_date
    range_min_price = flat_preference.range_min_price || flat_preference.start_min_price
    range_max_price = flat_preference.range_max_price || flat_preference.start_max_price
    preferences = flat_preference.attributes.filter_map { |k, v| k if v == true }
    flats.filter do |flat|
      availability_date = flat[:details]['configs'][0]['subconfigs'][0]['available_from'].to_date
      facilities = flat[:apartment_facilities].map { |facility| facility['kind'].tr('-', '_') }
      flat_min_price = flat[:details]['min_price'].to_i
      flat_max_price = flat[:details]['max_price'].to_i
      match_date_and_pricing = availability_date <= start_date && flat_min_price >= range_min_price && flat_max_price <= range_max_price
      filters_condition = match_date_and_pricing && preferences.present? && (preferences - facilities).empty?
      no_filters_condition = match_date_and_pricing && preferences.blank?
      flat if filters_condition || no_filters_condition
    end
  end

  def recommandations(flats)
    flats.first(12).map { |flat| { code: flat[:code], image: flat[:images][0]['url'], price: flat[:details]['disp_price'], billing: flat[:details]['billing'], name: flat[:details]['name'] }.to_json }
  end

  def codes(flats)
    flats.map { |flat| flat['code'] }
  end

  def flat
    uri = URI("https://uniacco.com/api/v1/uk/#{@location}/#{@property}")
    response = JSON.parse(Net::HTTP.get(uri))
    if response && (response['title'] != 'NOT_FOUND')
      hash = { code: @property, details: response, images: response['images'], facilities: response['facilities'], apartment_facilities: response['apartment_facilities'] }
      { error: nil, status: 200, payload: hash }
    end
  end

  def check_and_return_city_code
    uri = URI("https://uniacco.com/api/v1/countries/uk/cities")
    response = JSON.parse(Net::HTTP.get(uri))
    city = response['cities'].find { |city_uniacco| city_uniacco if @location.include?(city_uniacco['code']) }
    city['code'] unless city.nil?
  end
end
