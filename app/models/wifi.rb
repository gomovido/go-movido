class Wifi < ApplicationRecord
  belongs_to :category
  belongs_to :company
  belongs_to :country
  has_many :subscriptions, as: :product, dependent: :nullify
  has_many :product_features, dependent: :destroy
  has_many :product_feature_translations, through: :product_features, source: :translations
  has_many :special_offers, dependent: :destroy
  has_many :special_offer_translations, through: :special_offers, source: :translations
  has_and_belongs_to_many :coupons
  validates :name, :area, :price, :time_contract, :setup_price, :data_speed, presence: true
  validates :active, inclusion: { in: [true, false] }
  after_create :create_stripe_product
  after_create :set_full_name

  def set_full_name
    self.update(full_name: "#{self.company.name} - #{self.name}")
  end

  def create_stripe_product
    if self.stripe_id.nil?
      response = StripeApiProductService.new(product_id: self.id, type: self.category.name.capitalize).proceed
      self.update(stripe_id: response[:product_id]) if response[:product_id]
    end
  end

  def total_steps
    4
  end

  def uk?
    country.code == 'gb'
  end

  def obligation
    !time_contract.zero?
  end

  def price_cents
    (price * 100).to_i
  end

  def format_price
    format_price = (price % 1).zero? ? price.to_i.to_s : '%.2f' % price
    country.currency == 'GBP' ? "#{country.currency_sign}#{format_price}" : "#{format_price}#{country.currency_sign}"
  end

  def format_setup_price
    format_price = (setup_price % 1).zero? ? setup_price.to_i.to_s : '%.2f' % setup_price
    country.currency == 'GBP' ? "#{country.currency_sign}#{format_price}" : "#{format_price}#{country.currency_sign}"
  end

  def desc_preview
    area.size >= 20 ? "#{area.first(17)}..." : area
  end
end
