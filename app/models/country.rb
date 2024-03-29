class Country < ApplicationRecord
  validates :code, presence: true
  has_many :houses, dependent: :destroy
  has_many :products, dependent: :destroy

  def currency
    code == 'fr' ? 'EUR' : 'GBP'
  end

  def currency_symbol
    code == 'fr' ? '€' : '£'
  end

  def title
    code == 'fr' ? 'France' : 'United Kingdom'
  end

  def city
    code == 'fr' ? 'Paris' : 'London'
  end
end
