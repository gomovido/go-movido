class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  CATEGORIES = %w[wifi mobile flat bank gym transportation]

  validates :name, presence: true
  enum name: { wifi: 0, mobile: 1, flat: 2, bank: 3, gym: 4, transportation: 5 }

end
