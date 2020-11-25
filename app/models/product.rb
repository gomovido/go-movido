class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :sku, use: :slugged
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  validates :sku, presence: true
  monetize :sim_card_price_cents
  after_create :set_sim_card_price_currency


  def eligible?(user)
    self.category.name == 'mobile' ? true : user.active_address.valid_address
  end


  def set_sim_card_price_currency
    if self.country == 'United Kingdom'
      self.update(sim_card_price_currency: 'GBP')
    else
      self.update(sim_card_price_currency: 'EUR')
    end
  end
end
