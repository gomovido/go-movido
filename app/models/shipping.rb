class Shipping < ApplicationRecord
  has_many :orders, dependent: :nullify
  validates :address, :state, :tracking_id, :delivery_date, presence: true
end
