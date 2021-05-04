class Mobile < ApplicationRecord
  belongs_to :category
  belongs_to :company
  belongs_to :country
  has_many :subscriptions, as: :product, dependent: :nullify
  has_many :product_features, dependent: :destroy
  has_many :product_feature_translations, through: :product_features, source: :translations
  has_many :special_offers, dependent: :destroy
  has_many :special_offer_translations, through: :special_offers, source: :translations
  validates :data_unit, inclusion: { in: ["GB", "MB"] }, unless: :not_needed?
  validates :offer_type, inclusion: { in: ["call_only", "internet_only", "internet_and_call"] }
  validates :name, :area, :price, :offer_type, :time_contract, :sim_card_price, presence: true
  validates :sim_needed, inclusion: { in: [true, false] }
  validates :active, inclusion: { in: [true, false] }
  validates :data, presence: { if: :internet_only? }
  validates :call, presence: { if: :call_only? }
  validates :call, :data, presence: { if: :internet_and_call? }
  after_create :create_stripe_product


  def create_stripe_product
    response = StripeApiService.new(product_id: self.id).create_product
    p response
    self.update(stripe_id: response[:product_id]) if response[:product_id]
  end

  def uk?
    country.code == 'gb'
  end

  def format_data
    unlimited_data? ? 'unlimited' : "#{data}#{data_unit}"
  end

  def not_needed?
    data.nil? or data&.zero?
  end

  def unlimited_data?
    offer_type != "call_only" && data&.zero?
  end

  def unlimited_call?
    offer_type != 'internet_only' && call&.zero?
  end

  def payment?
    sim_card_price_cents >= 100
  end

  def total_steps
    payment? ? 4 : 3
  end

  def obligation
    !time_contract.zero?
  end

  def price_cents
    (price * 100).to_i
  end

  def sim_card_price_cents
    (sim_card_price * 100).to_i
  end

  def format_price
    format_price = (price % 1).zero? ? price.to_i.to_s : '%.2f' % price
    country.currency == 'GBP' ? "#{country.currency_sign}#{format_price}" : "#{format_price}#{country.currency_sign}"
  end

  def format_sim_card_price
    format_price = (sim_card_price % 1).zero? ? sim_card_price.to_i.to_s : '%.2f' % sim_card_price
    country.currency == 'GBP' ? "#{country.currency_sign}#{format_price}" : "#{format_price}#{country.currency_sign}"
  end

  def desc_preview
    area.size >= 20 ? "#{area.first(17)}..." : area
  end

  def internet_only?
    offer_type == 'internet_only'
  end

  def call_only?
    offer_type == 'call_only'
  end

  def internet_and_call?
    offer_type == 'internet_and_call'
  end
end
