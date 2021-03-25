class UniaccoApiService
  def initialize(params)
    @location = params[:location]
    @city_code = params[:city_code]
    @properties = params[:properties]
    @property = params[:property_code]
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
    { error: nil, status: 200, payload: array } if array.present?
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
