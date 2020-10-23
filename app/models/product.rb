class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :sku, use: :slugged
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  validates :sku, presence: true
end
