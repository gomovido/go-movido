module UniaccoAffiliateHelper
  def booking_link(location, code, country)
    "https://uniacco.com/#{country == 'fr' ? 'france' : 'uk'}/#{location.downcase}/#{code}?utm_source=partner&utm_medium=movido&source=api"
  end
end
