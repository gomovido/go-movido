class Product < ApplicationRecord
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy

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
    self.currency == 'GBP' ? self.currency_code + '' + self.price.to_f.to_s : self.price.to_f.to_s + '' + self.currency_code
  end

  def format_sim_card_price
    self.currency == 'GBP' ? self.currency_code + '' + self.sim_card_price.to_f.to_s : self.sim_card_price.to_f.to_s + '' + self.currency_code
  end

  def format_setup_price
    self.currency == 'GBP' ? self.currency_code + '' + self.setup_price.to_f.to_s : self.setup_price.to_f.to_s + '' + self.currency_code
  end

  def country_code
    if self.country == 'United Kingdom'
      'uk'
    elsif self.country == 'France'
      'fr'
    end
  end
end
