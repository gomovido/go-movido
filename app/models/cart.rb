class Cart < ApplicationRecord
  belongs_to :house
  has_many :items, dependent: :destroy
end
