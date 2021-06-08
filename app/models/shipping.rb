class Shipping < ApplicationRecord
  attr_accessor :address_mapbox

  has_one :order, dependent: :nullify
  validates :address, :state, presence: true
  validates :state, inclusion: { in: ['initiated', "delivering", "delivered"] }
  validate :address_is_valid

  def address_is_valid
    errors.add(:address_mapbox, "is invalid") if address_mapbox.blank?
  end
end
