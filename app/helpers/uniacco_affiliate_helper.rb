module UniaccoAffiliateHelper
  def booking_link(location, code)
    "#{ENV['UNIACCO_URL']}/#{location.downcase}/#{code}?utm_source=partner&utm_medium=movido&source=api"
  end
end
