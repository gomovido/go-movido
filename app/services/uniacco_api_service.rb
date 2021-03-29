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
    if response && (response['title'] == 'NOT_FOUND')
      { error: 'NOT_FOUND', status: 404, payload: nil }
    else
      { error: nil, status: 200, payload: response['properties'].flatten }
    end
  end

  def avanced_list_flats
    array = []
    @properties.map do |property|
      uri = URI("https://uniacco.com/api/v1/uk/#{@location}/#{property}")
      response = JSON.parse(Net::HTTP.get(uri))
      array << { code: property, details: response, images: response['images'], facilities: response['facilities'], apartment_facilities: response['apartment_facilities'] } if response && (response['title'] != 'NOT_FOUND')
    end
    if array.present?
      response = { error: nil, status: 200, payload: array }
      flats = filters(response[:payload], @filters_list, @start_date)
      { error: nil, status: 200, flats: flats, recommandations: recommandations(flats)}
    end
  end

  def filters(flats, filters_list, start_date)
    flats.filter do |flat|
      availability_date = flat[:details]['configs'][0]['subconfigs'][0]['available_from'].to_date
      if filters_list.present?
        facilities = flat[:apartment_facilities].map { |facility| facility['kind'] }
        flat if (filters_list - facilities).empty? && availability_date <= start_date
      elsif availability_date <= start_date.to_date
        flat
      end
    end
  end

  def recommandations(flats)
    flats.first(4).map { |flat| { code: flat[:code], image: flat[:images][0]['url'], price: flat[:details]['disp_price'], billing: flat[:details]['billing'], name: flat[:details]['name'] } }
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
