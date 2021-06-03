class Product < ApplicationRecord
  belongs_to :company
  belongs_to :category
  has_many :product_details
  validates :name, :sku, :description, :currency, :activation_price, :subscription_price, presence: true
end
