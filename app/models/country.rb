class Country < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :mobiles, dependent: :destroy
  has_many :wifis, dependent: :destroy
  has_many :users, through: :addresses
  validates_presence_of :code

  def name
    I18n.t("country.#{self.code}")
  end

  def currency
    IsoCountryCodes.find(self.code).currency
  end

  def currency_sign
    I18n.t("country.#{self.currency.downcase}")
  end

end
