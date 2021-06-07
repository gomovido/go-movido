class Shipping < ApplicationRecord
  has_one :order, dependent: :nullify
  validates :address, :state, :tracking_id, :delivery_date, presence: true
  validates :state, inclusion: { in: ['initiated', "delivering", "delivered"] }
end
