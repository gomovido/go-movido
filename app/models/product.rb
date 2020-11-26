class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :sku, use: :slugged
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  validates :sku, presence: true
  monetize :sim_card_price_cents
  after_create :set_sim_card_price_currency

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
