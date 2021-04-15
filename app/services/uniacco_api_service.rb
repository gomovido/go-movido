class UniaccoApiService
  def initialize(params)
    @city_code = params[:city_code]
    @flat_preference_id = params[:flat_preference_id]
    @page = params[:page]
    @location = params[:location]
    @code = params[:code]
  end

  def flats
    uri = URI("https://uniacco.com/api/v1/cities/#{@city_code}/properties?sortBy=relevance")
    response = HTTParty.get(uri, headers: { "Content-Type" => "application/json" })
    format_response(response)
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
    query = { 'move_in' => flat_preference.move_in.strftime('%m-%Y'), 'facilities' => flat_preference.facilities.join(',') }
    uri = URI("https://uniacco.com/api/v1/cities/#{flat_preference.location}/properties?sortBy=relevance&page=#{@page}")
    response = HTTParty.get(uri, headers: { "Content-Type" => "application/json" }, query: query)
    advanced_list_flats(response, format_response(response))
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
        flat = hash[:flats].find { |flat, _v| flat['code'] == code }
        flat["configs"] = configs
        flat["facilities"] = configs.map { |c| c.map { |k, v| k if v == true }.compact }.reject { |c| c.empty? }.sort
      end
      return hash

    end
  end

  def format_response(response)
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
        flats: response['properties'],
        recommandations: recommandations(response['properties']),
        total_pages: response['pages'],
        count: response['count']
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
          code: @property,
          details: response,
          images: response['images'],
          facilities: response['facilities'],
          apartment_facilities: response['apartment_facilities'],
          community_facilities: response['community_facilities']
        }
      }
    end
  end
end
