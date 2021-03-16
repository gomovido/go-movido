class UniaccoApiService
  def initialize(params)
    @location = params[:location]
    @city_code = params[:city_code]
    @properties = params[:properties]
  end

  def list_flats
    uri = URI("https://uniacco.com/api/v1/cities/#{@city_code}/properties?page=8&sortBy=relevance")
    response = JSON.parse(Net::HTTP.get(uri))
    if response && response['title'] == 'NOT_FOUND'
      { error: 'NOT_FOUND', status: 404, payload: nil }
    else
      { error: nil, status: 200, payload: response['properties'] }
    end
  end

  def avanced_list_flats
    uri = URI("https://uniacco.com/api/v1/configs?properties=#{@properties}")
    response = JSON.parse(Net::HTTP.get(uri))
    if response && response['title'] == 'NOT_FOUND'
      { error: 'NOT_FOUND', status: 404, payload: nil }
    else
      details = get_flats_details(response['configs'])
      { error: nil, status: 200, payload: details}
    end
  end

  def get_flats_details(configs)
    array = []
    configs.map do |k, v|
      uri = URI("https://uniacco.com/api/v1/uk/#{@location}/#{k}")
      response = JSON.parse(Net::HTTP.get(uri))
      array << {code: k, details: response, images: response['images'], facilities: response['facilities'], configs: v}
    end
    array
  end


  def check_and_return_city_code
    uri = URI("https://uniacco.com/api/v1/countries/uk/cities")
    response = JSON.parse(Net::HTTP.get(uri))
    city = response['cities'].find { |city_uniacco| city_uniacco if @location.include?(city_uniacco['code']) }
    city['code'] unless city.nil?
  end
end
