class Charge < ApplicationRecord
  has_one :order, dependent: :nullify

  validates :state, presence: true
end
