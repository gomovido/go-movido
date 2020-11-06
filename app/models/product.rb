class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :sku, use: :slugged
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :product_features, dependent: :destroy
  validates :sku, presence: true


  def eligible?(user)
    self.category.name == 'mobile' ? true : user.active_address.valid_address
  end
end
