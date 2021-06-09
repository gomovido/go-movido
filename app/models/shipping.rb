class Shipping < ApplicationRecord
  has_one :order, dependent: :nullify
  validates :address, :state, presence: true
  validates :state, inclusion: { in: ['initiated', "delivering", "delivered"] }
end
