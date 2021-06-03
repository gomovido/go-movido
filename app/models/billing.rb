class Billing < ApplicationRecord
  has_many :orders
  validates :address, presence: true
end
