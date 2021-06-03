class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, :sku, :description, presence: true
  validates :name, :sku, uniqueness: true
end
