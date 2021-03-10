class UniaccoApiService
  def initialize(params)
    @location = params[:location]
    @city_code = params[:city_code]
  end

  def list_flats
    uri = URI("https://uniacco.com/api/v1/cities/#{@city_code}/properties?page=1&sortBy=relevance")
    response = JSON.parse(Net::HTTP.get(uri))
    if response && response['title'] == 'NOT_FOUND'
      { error: 'NOT_FOUND', status: 404, payload: nil }
    else
      { error: nil, status: 200, payload: response['properties'] }
    end
  end

  def check_and_return_city_code
    uri = URI("https://uniacco.com/api/v1/countries/uk/cities")
    response = JSON.parse(Net::HTTP.get(uri))
    city = response['cities'].find { |city_uniacco| city_uniacco if @location.include?(city_uniacco['code']) }
    city['code'] unless city.nil?
  end
end
