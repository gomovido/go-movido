class Mobile < ApplicationRecord
  belongs_to :category
  belongs_to :company
  belongs_to :country
  has_many :subscriptions, as: :product
  has_many :product_features, dependent: :destroy
  has_many :special_offers, dependent: :destroy
  validates :data_unit, inclusion: { in: ["GB", "MB"] }, unless: :unlimited_data?
  validates :offer_type, inclusion: { in: ["call_only", "internet_only", "internet_and_call"] }
  validates_presence_of :name, :area, :price, :offer_type, :time_contract, :sim_card_price
  validates_inclusion_of :sim_needed, in: [true, false]
  validates_inclusion_of :active, in: [true, false]
  validates_presence_of :data, if: :internet_only?
  validates_presence_of :call, if: :call_only?
  validates_presence_of :call, :data, if: :internet_and_call?


  def format_data
    unlimited_data? ? 'unlimited' : "#{data}#{data_unit}"
  end

  def unlimited_data?
    data.zero? && offer_type != 'call_only'
  end

  def unlimited_call?
    call.zero? && offer_type != 'internet_only'
  end

  def has_payment?
    self.sim_card_price_cents >= 100
  end

  def total_steps
    self.has_payment? ? 4 : 3
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
    format_price = price % 1 != 0 ? '%.2f' % price : price.to_i.to_s
    country.currency == 'GBP' ? country.currency_sign + '' + format_price : format_price + '' + country.currency_sign
  end

  def format_sim_card_price
    format_price = sim_card_price % 1 != 0 ? '%.2f' % sim_card_price : sim_card_price.to_i.to_s
    country.currency == 'GBP' ? country.currency_sign + '' + format_price : format_price + '' + country.currency_sign
  end

  def desc_preview
    area.size >= 20 ? area.first(17) + '...' : area
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

  def unlimited_data?
    data.nil? or data.zero?
  end

end
