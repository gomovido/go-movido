class Product < ApplicationRecord
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  has_many :special_offers, dependent: :destroy

  def is_wifi?
    self.category.name == 'wifi'
  end

  def is_mobile?
    self.category.name == 'mobile'
  end

  def has_payment?
    self.sim_card_price_cents >= 100
  end

  def total_steps
    self.is_mobile? && !self.has_payment? ? 3 : 4
  end

  def obligation
    self.time_contract != 'no'
  end

  def currency_code
    self.currency == 'GBP' ? '£' : '€'
  end

  def price_cents
    (self.price * 100).to_i
  end

  def sim_card_price_cents
    (self.sim_card_price * 100).to_i
  end

  def format_price
    format_price = self.price % 1 != 0 ? '%.2f' % self.price : self.price.to_i.to_s
    self.currency == 'GBP' ? self.currency_code + '' + format_price : format_price + '' + self.currency_code
  end

  def format_sim_card_price
    format_price = self.sim_card_price % 1 != 0 ? '%.2f' % self.sim_card_price : self.sim_card_price.to_i.to_s
    self.currency == 'GBP' ? self.currency_code + '' + format_price : format_price + '' + self.currency_code
  end

  def format_setup_price
    format_price = self.setup_price % 1 != 0 ? '%.2f' % self.setup_price : self.setup_price.to_i.to_s
    self.currency == 'GBP' ? self.currency_code + '' + format_price : format_price + '' + self.currency_code
  end

  def desc_preview
    self.description.size >= 20 ? self.description.first(17) + '...' : self.description
  end

  def country_code
    if self.country == 'United Kingdom'
      'uk'
    elsif self.country == 'France'
      'fr'
    end
  end
end
