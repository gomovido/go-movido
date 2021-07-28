class Cart < ApplicationRecord
  belongs_to :house
  has_many :items, dependent: :destroy
  has_many :products, through: :items
end
