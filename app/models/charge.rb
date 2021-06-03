class Charge < ApplicationRecord
  has_many :orders, dependent: :nullify
  has_many :items, dependent: :destroy

  validates :state, :stripe_charge_id, presence: true
end
