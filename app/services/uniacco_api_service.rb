class UniaccoApiService
  def initialize(params)
    @location = params[:location]
    @city_code = params[:city_code]
    @properties = params[:properties]
    @property = params[:property_code]
    @active_filters = params[:active_filters]
    @flat_preference_id = params[:flat_preference_id]
    @country = params[:country]
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
    if response && (response['title'] == 'NOT_FOUND')
      {
        error: 'NOT_FOUND',
        status: 404,
        flats: nil
      }
    else
      recommandations = payload.first(12).map do |flat|
        {
          code: flat['code'],
          image: flat['images'][0]['url'],
          price: flat['disp_price'],
          billing: flat['billing'],
          name: flat['name']
        }.to_json
      end
      {
        error: nil,
        status: 200,
        flats: payload,
        recommandations: recommandations,
        codes: codes(payload)
      }
    end
  end

  def avanced_list_flats
    flat_preference = FlatPreference.find(@flat_preference_id)
    array = @properties.map do |property|
      uri = URI("https://uniacco.com/api/v1/uk/#{flat_preference.location}/#{property}")
      response = JSON.parse(Net::HTTP.get(uri))
      next unless response && (response['title'] != 'NOT_FOUND')

      {
        code: property,
        details: response,
        images: response['images'],
        facilities: response['facilities'],
        apartment_facilities: response['apartment_facilities']
      }
    end
    return if array.blank?

    flats = filters(array, flat_preference.move_in, flat_preference.min_price, flat_preference.max_price, flat_preference.facilities)
    {
      error: nil,
      status: 200,
      flats: flats,
      recommandations: recommandations(flats)
    }
  end

  def filters(flats, start_date, min_price, max_price, facilities)
    flats.filter do |flat|
      flat_start_date = flat[:details]['configs'][0]['subconfigs'][0]['available_from'].to_date
      flat_facilities = flat[:apartment_facilities].map { |facility| facility['kind'].tr('-', '_') }
      flat_price = (flat[:details]['min_price'].to_i + flat[:details]['max_price'].to_i) / 2
      match_date_and_pricing = flat_start_date <= start_date && flat_price.between?(min_price, max_price)
      flat if match_date_and_pricing && ((facilities.present? && (facilities - flat_facilities).empty?) || facilities.blank?)
    end
  end

  def recommandations(flats)
    flats.first(5).map do |flat|
      {
        code: flat[:code],
        image: flat[:images][0]['url'],
        price: flat[:details]['disp_price'],
        billing: flat[:details]['billing'],
        name: flat[:details]['name']
      }.to_json
    end
  end

  def codes(flats)
    flats.map { |flat| flat['code'] }
  end

  def flat
    uri = URI("https://uniacco.com/api/v1/uk/#{@location}/#{@property}")
    response = JSON.parse(Net::HTTP.get(uri))
    return unless response && response['title'] != 'NOT_FOUND'

    {
      error: nil,
      status: 200,
      payload: {
        code: @property,
        details: response,
        images: response['images'],
        facilities: response['facilities'],
        apartment_facilities: response['apartment_facilities']
      }
    }
  end

  def check_and_return_city_code
    uri = URI("https://uniacco.com/api/v1/countries/uk/cities")
    response = JSON.parse(Net::HTTP.get(uri))
    city = response['cities'].find { |city_uniacco| city_uniacco if @location.include?(city_uniacco['code']) }
    city['code'] unless city.nil?
  end
end
