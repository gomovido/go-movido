class UniaccoApiService
  def initialize(params)
    @city_code = params[:city_code]
    @flat_preference_id = params[:flat_preference_id]
  end

  def flats
    uri = URI("https://uniacco.com/api/v1/cities/#{@city_code}/properties?sortBy=relevance")
    response = HTTParty.get(uri, headers: { "Content-Type" => "application/json" })
    format_response(response)
  end


  def recommandations(properties)
    properties.first(5).map do |flat|
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
    query = {'facilities' => ['wifi', 'gym'].join(','), 'move_in' => '03-2021'}
    uri = URI("https://uniacco.com/api/v1/cities/#{flat_preference.location}/properties?sortBy=relevance")
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
      codes = response['properties'].map{|property| property['code']}.join(',')
      uri = URI("https://uniacco.com/api/v1/configs?properties=#{codes}")
      response = HTTParty.get(uri, headers: { "Content-Type" => "application/json" })
      raise

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



  # def avanced_list_flats
  #   flat_preference = FlatPreference.find(@flat_preference_id)
  #   array = @properties.map do |property|
  #     uri = URI("https://uniacco.com/api/v1/#{flat_preference.country == 'fr' ? 'france' : 'uk'}/#{flat_preference.location}/#{property}")
  #     response = JSON.parse(Net::HTTP.get(uri))
  #     next unless response && (response['title'] != 'NOT_FOUND')

  #     {
  #       code: property,
  #       details: response,
  #       images: response['images'],
  #       facilities: response['facilities'],
  #       apartment_facilities: response['apartment_facilities'],
  #       community_facilities: response['community_facilities']
  #     }
  #   end
  #   return if array.blank?

  #   flats = filters(array, flat_preference.move_in, flat_preference.min_price, flat_preference.max_price, flat_preference.facilities)
  #   {
  #     error: nil,
  #     status: 200,
  #     flats: flats,
  #     recommandations: recommandations(flats)
  #   }
  # end

  # def filters(flats, start_date, min_price, max_price, facilities)
  #   flats.filter do |flat|
  #     flat_start_date = flat[:details]['configs'][0]['subconfigs'][0]['available_from'].to_date
  #     flat_facilities = flat[:apartment_facilities].map { |facility| facility['kind'].tr('-', '_') }
  #     flat_price = (flat[:details]['min_price'].to_i + flat[:details]['max_price'].to_i) / 2
  #     match_date_and_pricing = flat_start_date <= start_date && flat_price.between?(min_price, max_price)
  #     flat if match_date_and_pricing && ((facilities.present? && (facilities - flat_facilities).empty?) || facilities.blank?)
  #   end
  # end

  # def recommandations(flats)
  #   flats.first(5).map do |flat|
  #     {
  #       code: flat[:code],
  #       image: flat[:images][0]['url'],
  #       price: flat[:details]['disp_price'],
  #       billing: flat[:details]['billing'],
  #       name: flat[:details]['name']
  #     }.to_json
  #   end
  # end

  # def codes(flats)
  #   flats.map { |flat| flat['code'] }
  # end

  # def flat
  #   flat_preference = FlatPreference.find(@flat_preference_id)
  #   uri = URI("https://uniacco.com/api/v1/#{flat_preference.country == 'fr' ? 'france' : 'uk'}/#{@location}/#{@property}")
  #   response = JSON.parse(Net::HTTP.get(uri))
  #   return unless response && response['title'] != 'NOT_FOUND'

  #   {
  #     error: nil,
  #     status: 200,
  #     payload: {
  #       code: @property,
  #       details: response,
  #       images: response['images'],
  #       facilities: response['facilities'],
  #       apartment_facilities: response['apartment_facilities'],
  #       community_facilities: response['community_facilities']
  #     }
  #   }
  # end


end
