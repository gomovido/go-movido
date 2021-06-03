class Billing < ApplicationRecord
  has_many :orders, dependent: :nullify
  validates :address, presence: true
end
