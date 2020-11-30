class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :sku, use: :slugged
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  monetize :sim_card_price_cents
  after_create :set_sim_card_price_currency

  #presence
  validates_presence_of :company, :name, :description, :price, :logo_url, :call_limit, :data_limit, :time_contract, :unlimited_call, :unlimited_data, :obligation
  #uniqueness
  validates_uniqueness_of :company, case_sensitive: false
  # conditional & special formats
  validates :price, numericality: { greater_than_or_equal_to: 1,  only_integer: true }, if: :sim_needed?
  validates :logo_url, url: true
  validates :call_limit, inclusion: { in: %w[unlimited Unlimited] }, if: :unlimited_call?
  validates :data_limit, inclusion: { in: %w[unlimited Unlimited] }, if: :unlimited_data?
  validates :time_contract, inclusion: { in: %w[no No] }, unless: :obligation?

  def is_wifi?
    self.category.name == 'wifi'
  end

  def is_mobile?
    self.category.name == 'mobile'
  end

  def has_payment?
    self.sim_card_price_cents >= 1
  end

  def total_steps
    self.is_mobile? && !self.has_payment? ? 3 : 4
  end

  def set_sim_card_price_currency
    if self.country == 'United Kingdom'
      self.update(sim_card_price_currency: 'GBP')
    else
      self.update(sim_card_price_currency: 'EUR')
    end
  end
end
