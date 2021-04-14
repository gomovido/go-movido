class AggregatorApiService
  def initialize(params)
    @flat = params[:flat]
    @type = params[:type]
  end

  def format_flat
    hash = {
      images: [],
      facilities: [],
      apartment_facilities: [],
      community_facilities: [],
      rooms: [],
      bedrooms_facilities: [],
      floors: []
    }
    case @type
    when 'student_housing'
      hash[:code] = @flat[:code]
      hash[:title] = @flat[:details]['name']
      hash[:description] = @flat[:details]['intro']
      hash[:city] = @flat[:details]['city_name']
      hash[:country] = @flat[:details]['country_name']
      hash[:price] = @flat[:details]['disp_price']
      hash[:billing] = @flat[:details]['billing'].downcase
      hash[:currency_code] = @flat[:details]['currency_code']
      hash[:images] = @flat[:images].map { |i| { url: i['url'] } }
      hash[:facilities] = @flat[:facilities].map { |f| { name: f } }
      hash[:apartment_facilities] = @flat[:apartment_facilities].map { |af| { name: af['name'] } }
      hash[:community_facilities] = @flat[:community_facilities].map { |af| { name: af['name'] } }
      hash[:rooms] = @flat[:details]['configs'].map { |c| { name: c['name'], description: c['description'], price: c['disp_price'], deposit: c['deposit'], subconfigs: c['subconfigs'], facilities: c['facilities'] } }
    when 'entire_flat'
      hash[:code] = @flat['id']
      hash[:title] = @flat['accommodation_offer']['title'].find { |k, _v| k['locale_code'] == 'en_GB' }['text']
      hash[:description] = @flat['property_aggregate']['property']['metadata'].find { |k, _v| k['locale_code'] == 'en_GB' }['text']
      hash[:city] = @flat['property_aggregate']['property']['location']['address']['city_code'].split('-')[1]
      hash[:country] = @flat['property_aggregate']['property']['location']['address']['city_code'].split('-')[0]
      hash[:price] = @flat['accommodation_offer']['contract']['standard']['rents']['1']['amount'] / 100
      hash[:billing] = @flat['accommodation_offer']['contract']['type']
      hash[:currency_code] = @flat['accommodation_offer']['contract']['standard']['rents']['1']['currency_code']
      hash[:images] = @flat['property_aggregate']['photos'].map { |k, _v| { url: "https://cdn-static.staging-uniplaces.com/property-photos/#{k['hash']}/medium.jpg" } }
      hash[:facilities] = @flat['property_aggregate']['property']['features'].map { |k, _v| { name: k['Code'] } }
      hash[:apartment_facilities] = @flat['property_aggregate']['property_type']['configuration']['allowed_features'].map { |f| { name: f } }
      hash[:bedrooms_facilities] = @flat['property_aggregate']['property']['features'].map { |k, _v| { name: k['Code'] } if k['Exists'] == true }.compact
    end
    return hash
  end
end
