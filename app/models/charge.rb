class Charge < ApplicationRecord
  has_many :orders
  validates :state, :stripe_charge_id, presence: true
end
