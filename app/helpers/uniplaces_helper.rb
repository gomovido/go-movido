module UniplacesHelper
  def flat_image(image)
    "https://cdn-static.uniplaces.com/property-photos/#{image}/small.jpg"
  end

  def flat_price(flat)
    price = flat['attributes']['accommodation_offer']['price']['amount'] / 100
    currency = flat['attributes']['accommodation_offer']['price']['currency_code']
    billing = flat['attributes']['accommodation_offer']['contract_type']
    "#{price} #{currency.downcase}/ #{billing}"
  end
end
