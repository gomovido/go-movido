class Charge < ApplicationRecord
  has_one :order, dependent: :nullify
  belongs_to :coupon, optional: true

  validates :state, presence: true
end
