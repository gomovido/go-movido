class Product < ApplicationRecord
  belongs_to :category
  belongs_to :company
  belongs_to :country
  has_many :subscriptions, dependent: :destroy

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

  def price_cents
    (self.price * 100).to_i
  end

  def sim_card_price_cents
    (self.sim_card_price * 100).to_i
  end

  def format_price
    format_price = self.price % 1 != 0 ? '%.2f' % self.price : self.price.to_i.to_s
    self.country.currency == 'GBP' ? self.country.currency_sign + '' + format_price : format_price + '' + self.country.currency_sign
  end

  def format_sim_card_price
    format_price = self.sim_card_price % 1 != 0 ? '%.2f' % self.sim_card_price : self.sim_card_price.to_i.to_s
    self.country.currency == 'GBP' ? self.country.currency_sign + '' + format_price : format_price + '' + self.country.currency_sign
  end

  def format_setup_price
    format_price = self.setup_price % 1 != 0 ? '%.2f' % self.setup_price : self.setup_price.to_i.to_s
    self.country.currency == 'GBP' ? self.country.currency_sign + '' + format_price : format_price + '' + self.country.currency_sign
  end

  def desc_preview
    self.description.size >= 20 ? self.description.first(17) + '...' : self.description
  end
end
