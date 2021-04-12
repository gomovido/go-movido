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
    if payload
      {
        error: nil,
        status: 200,
        flats: payload,
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
    payload = response
    #TODO
    if payload
      {
        error: nil,
        status: 200,
        flat: payload,
        recommandations:  [],
        codes: [],
        total_pages: 1
      }
    end
  end
end
