class HousingApiService
  def initialize(params)
    @country_code = params[:country_code]
    @city = params[:city]
  end

  def retrieve_city_code
    uri = URI("https://uniacco.com/api/v1/countries/#{@country_code}/cities")
    response = JSON.parse(Net::HTTP.get(uri))
    response['cities'].find {|city| city if city['code'] == @city}
  end

  def list_flats
    city_code = retrieve_city_code['code']
    uri = URI("https://uniacco.com/api/v1/cities/#{city_code}/properties?page=1&sortBy=relevance")
    response = JSON.parse(Net::HTTP.get(uri))
    response['properties']
  end
end

