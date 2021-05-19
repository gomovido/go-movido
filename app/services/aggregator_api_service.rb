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
      format_uniacco(hash, @flat)
    when 'entire_flat', 'flatshare'
      format_uniplaces(hash, @flat)
    end
    return hash
  end

  def format_uniacco(hash, flat)
    hash[:code] = flat[:code]
    hash[:title] = flat[:details]['name']
    hash[:description] = flat[:details]['intro']
    hash[:city] = flat[:details]['city_name']
    hash[:country] = flat[:details]['country_name']
    hash[:price] = flat[:details]['disp_price']
    hash[:billing] = flat[:details]['billing']
    hash[:currency_code] = flat[:details]['currency_code']
    hash[:images] = flat[:images].map { |i| { url: i['url'] } }
    hash[:facilities] = flat[:facilities].map { |f| { name: f } }
    hash[:apartment_facilities] = flat[:apartment_facilities].map { |af| { name: af['name'] } }
    hash[:community_facilities] = flat[:community_facilities].map { |af| { name: af['name'] } }
    hash[:rooms] = flat[:details]['configs'].map { |c| { name: c['name'], description: c['description'], price: "#{flat[:details]['rate_unit']}#{c['price'].to_i}", deposit: c['deposit'], subconfigs: c['subconfigs'], facilities: c['facilities'] } }
  end

  def format_uniplaces(hash, flat)
    hash[:code] = flat['id']
    hash[:title] = flat['accommodation_offer']['title'].find { |k, _v| k['locale_code'] == 'en_GB' }['text']
    data = flat['property_aggregate']['property']['metadata']
    hash[:description] = data.find { |k, _v| k['locale_code'] == 'en_GB' || 'fr_FR' }['text'] if data
    hash[:city] = flat['property_aggregate']['property']['location']['address']['city_code'].split('-')[1]
    hash[:country] = flat['property_aggregate']['property']['location']['address']['city_code'].split('-')[0]
    hash[:billing] = 'monthly'
    hash[:billing_details] = {
      type: flat['accommodation_offer']['contract']['type'].capitalize,
      included_bills: flat['accommodation_offer']['costs']['bills'].map { |type, conditions| type.capitalize if conditions["included"] == true }.compact,
      cancellation_policy: flat['accommodation_offer']['requisites']['conditions']['cancellation_policy'].titlecase,
      deposit: "#{flat['accommodation_offer']['contract']['deposit']['value']['amount'] / 100} #{flat['accommodation_offer']['reference_price']['currency_code']}",
      min_nights: flat['accommodation_offer']['requisites']['conditions']['minimum_nights']
    }
    hash[:rules] = flat['property_aggregate']['property']['rules'].map { |rule| rule['code'].remove("-allowed").insert(0, "no-").titlecase if rule['exists'] == false }.compact if flat['property_aggregate']['property']['rules'].present?
    hash[:price] = flat['accommodation_offer']['reference_price']['amount'] / 100
    hash[:currency_code] = flat['accommodation_offer']['reference_price']['currency_code']
    hash[:images] = flat['property_aggregate']['photos'].map { |k, _v| { url: "https://#{Rails.env.production? ? 'cdn-static-new.uniplaces.com' : 'cdn-static.staging-uniplaces.com'}/property-photos/#{k['hash']}/x-large.jpg" } }
    hash[:facilities] = flat['property_aggregate']['property']['features'].map { |k, _v| { name: k['Code'] } } if flat['property_aggregate']['property']['features'].present?
    hash[:bedrooms_facilities] = flat['property_aggregate']['property']['features'].map { |k, _v| { name: k['Code'].titlecase } if k['Exists'] == true }.compact if flat['property_aggregate']['property']['features'].present?
  end
end
