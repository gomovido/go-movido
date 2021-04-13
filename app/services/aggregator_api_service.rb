class AggregatorApiService
  def initialize(params)
    @flat = params[:flat]
    @type = params[:type]
  end

  def format_flat
    if @type == 'student_housing'
      hash = {
        code: @flat[:code],
        title: @flat[:details]['name'],
        description: @flat[:details]['intro'],
        city: @flat[:details]['city_name'],
        country: @flat[:details]['country_name'],
        images: [],
        facilities: [],
        apartment_facilities: [],
        community_facilities: [],
        rooms: [],
        bedrooms_facilities: [],
        floors: [],
        price: @flat[:details]['disp_price'],
        billing: @flat[:details]['billing'].downcase,
        currency_code: @flat[:details]['currency_code']
      }
      hash[:images] = @flat[:images].map {|i| {url: i['url']}}
      hash[:facilities] = @flat[:facilities].map {|f| {name: f}}
      hash[:apartment_facilities] = @flat[:apartment_facilities].map{|af| {name: af['name']}}
      hash[:community_facilities] = @flat[:community_facilities].map{|af| {name: af['name']}}
      hash[:rooms] = @flat[:details]['configs'].map{|c| {name: c['name'], description: c['description'], price: c['disp_price'], deposit: c['deposit'], subconfigs: c['subconfigs'], facilities: c['facilities']}}
      hash
    elsif @type == 'entire_@flat'
      hash = {
        code: @flat['id'],
        title: @flat['accommodation_offer']['title'].select{|k,v| k['locale_code'] == 'en_GB'}[0]['text'],
        description: @flat['property_aggregate']['property']['metadata'].select{|k,v| k['locale_code'] == 'en_GB'}[0]['text'],
        city: @flat['property_aggregate']['property']['location']['address']['city_code'].split('-')[1],
        country: @flat['property_aggregate']['property']['location']['address']['city_code'].split('-')[0],
        images: [],
        facilities: [],
        apartment_facilities: [],
        community_facilities: [],
        rooms: [],
        bedrooms_facilities: [],
        floors: [],
        price: @flat['accommodation_offer']['contract']['standard']['rents']['1']['amount'] / 100,
        billing: @flat['accommodation_offer']['contract']['type'],
        currency_code: @flat['accommodation_offer']['contract']['standard']['rents']['1']['currency_code']
      }
      hash[:images] = @flat['property_aggregate']['photos'].map{|k, v| {url: "https://cdn-static.staging-uniplaces.com/property-photos/#{k['hash']}/medium.jpg"}}
      hash[:facilities] = @flat['property_aggregate']['property']['features'].map{|k, v| {name: k['Code']}}
      hash[:apartment_facilities] = @flat['property_aggregate']['property_type']['configuration']['allowed_features'].map{|f| {name: f}}
      hash[:bedrooms_facilities] = @flat['property_aggregate']['property']['features'].map{|k, v| {name: k['Code']} if k['Exists'] == true}.compact
      hash
    end
  end
end
