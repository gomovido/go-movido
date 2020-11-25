class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :sku, use: :slugged
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  validates :sku, presence: true
  monetize :sim_card_price_cents


  def eligible?(user)
    self.category.name == 'mobile' ? true : user.active_address.valid_address
  end


  def is_wifi?
    self.category.name == 'wifi'
  end

  def is_mobile?
    self.category.name == 'mobile'
  end
end
