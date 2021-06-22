class Country < ApplicationRecord
  validates :code, presence: true
  has_many :user_preferences, dependent: :destroy
  has_many :products, dependent: :destroy

  def currency
    code == 'fr' ? 'EUR' : 'GBP'
  end

  def currency_symbol
    code == 'fr' ? '€' : '£'
  end
end
