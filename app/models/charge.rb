class Charge < ApplicationRecord
  has_one :order, dependent: :nullify

  validates :state, :stripe_charge_id, presence: true
end
