class UniaccoApiService
  def initialize(params)
    @location = params[:location]
    @city_code = params[:city_code]
    @properties = params[:properties]
    @property = params[:property_code]
    @active_filters = params[:active_filters]
    @start_date = params[:start_date]
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
      { error: 'NOT_FOUND', status: 404, payload: nil }
    else
      recommandations = payload.first(12).map { |flat| { code: flat['code'], image: flat['images'][0]['url'], price: flat['disp_price'], billing: flat['billing'], name: flat['name'] } }
      { error: nil, status: 200, payload: payload, min_price: min_price, max_price: max_price, recommandations: recommandations, codes: codes(payload) }
    end
  end

  def avanced_list_flats
    array = []
    @properties.map do |property|
      uri = URI("https://uniacco.com/api/v1/uk/#{@location}/#{property}")
      response = JSON.parse(Net::HTTP.get(uri))
      array << { code: property, details: response, images: response['images'], facilities: response['facilities'], apartment_facilities: response['apartment_facilities'] } if response && (response['title'] != 'NOT_FOUND')
    end
    return if array.blank?

    response = { error: nil, status: 200, payload: array }
    flats = filters(response[:payload], @active_filters, @start_date.to_date)
    { error: nil, status: 200, flats: flats, recommandations: recommandations(flats) }
  end

  def filters(flats, active_filters, start_date)
    p 'THIS IS FILTERS METHOD IN SERVICE'
    active_filters_flat = active_filters
    min = active_filters['min']
    max = active_filters['max']
    facilities_filters = active_filters_flat.except('min', 'max').map{|k, v| k}
    p 'THIS IS FACILITIES FILTERS'
    p facilities_filters
    flats.filter do |flat|
      availability_date = flat[:details]['configs'][0]['subconfigs'][0]['available_from'].to_date
      if facilities_filters.present?
        facilities = flat[:apartment_facilities].map { |facility| facility['kind'] }

        flat if (facilities_filters - facilities).empty? && availability_date <= start_date
      elsif availability_date <= start_date
        flat
      end
    end
  end

  def recommandations(flats)
    flats.first(12).map { |flat| { code: flat[:code], image: flat[:images][0]['url'], price: flat[:details]['disp_price'], billing: flat[:details]['billing'], name: flat[:details]['name'] } }
  end

  def codes(flats)
    flats.map { |flat| flat['code'] }.join(',')
  end

  def flat
    uri = URI("https://uniacco.com/api/v1/uk/#{@location}/#{@property}")
    response = JSON.parse(Net::HTTP.get(uri))
    hash = { code: @property, details: response, images: response['images'], facilities: response['facilities'], apartment_facilities: response['apartment_facilities'] } if response && (response['title'] != 'NOT_FOUND')
    { error: nil, status: 200, payload: hash } unless hash[:code].nil?
  end

  def check_and_return_city_code
    uri = URI("https://uniacco.com/api/v1/countries/uk/cities")
    response = JSON.parse(Net::HTTP.get(uri))
    city = response['cities'].find { |city_uniacco| city_uniacco if @location.include?(city_uniacco['code']) }
    city['code'] unless city.nil?
  end
end
