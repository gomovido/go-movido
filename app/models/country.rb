class Country < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :mobiles, dependent: :destroy
  has_many :wifis, dependent: :destroy
  has_many :users, through: :addresses
  validates_presence_of :code

  def name
    I18n.t("country.#{code}")
  end

  def currency
    IsoCountryCodes.find(code).currency
  end

  def currency_sign
    I18n.t("country.#{currency.downcase}")
  end
end
