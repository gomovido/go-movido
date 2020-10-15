class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  CATEGORIES = %w[wifi mobile flat bank gym transportation]

  validates :name, presence: true, inclusion: { in: CATEGORIES }

end
