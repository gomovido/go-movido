class Charge < ApplicationRecord
  has_one :order, dependent: :nullify
  has_many :items, dependent: :destroy

  validates :state, :stripe_charge_id, presence: true
end
