class Shipping < ApplicationRecord
  has_many :orders
  validates :address, :state, :tracking_id, :delivery_date, presence: true
end
