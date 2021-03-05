class Wifi < ApplicationRecord
  belongs_to :category
  belongs_to :company
  belongs_to :country
  has_many :subscriptions, as: :product
  has_many :product_features, dependent: :destroy
  has_many :product_feature_translations, through: :product_features, source: :translations
  has_many :special_offers, dependent: :destroy
  has_many :special_offer_translations, through: :special_offers, source: :translations
  validates_presence_of :name, :area, :price, :time_contract, :setup_price, :data_speed
  validates_inclusion_of :active, in: [true, false]

  def total_steps
    4
  end

  def is_uk?
    self.country.code == 'gb'
  end

  def obligation
    !time_contract.zero?
  end

  def price_cents
    (price * 100).to_i
  end

  def format_price
    format_price = price % 1 != 0 ? '%.2f' % price : price.to_i.to_s
    country.currency == 'GBP' ? country.currency_sign + '' + format_price : format_price + '' + country.currency_sign
  end

  def format_setup_price
    format_price = setup_price % 1 != 0 ? '%.2f' % setup_price : setup_price.to_i.to_s
    country.currency == 'GBP' ? country.currency_sign + '' + format_price : format_price + '' + country.currency_sign
  end

  def desc_preview
    area.size >= 20 ? area.first(17) + '...' : area
  end

end
