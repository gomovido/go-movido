module FlatsHelper
  def flat_image(image)
    "https://#{Rails.env.production? ? 'cdn-static-new.uniplaces.com' : 'cdn-static.staging-uniplaces.com'}/property-photos/#{image}/small.jpg"
  end

  def flat_price(flat)
    price = flat['attributes']['accommodation_offer']['price']['amount'] / 100
    currency = flat['attributes']['accommodation_offer']['price']['currency_code']
    billing = 'monthly'
    "#{manage_currency(currency.downcase)}#{price} / #{I18n.t("flats.index.frequency.#{billing}")}"
  end

  def manage_currency(currency_code)
    currencies = { 'eur' => '€', 'gbp' => '£', 'usd' => '$', '£' => '£', '€' => '€' }
    currencies[currency_code]
  end
end
