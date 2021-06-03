class Billing < ApplicationRecord
  has_one :order, dependent: :nullify
  validates :address, presence: true
end
