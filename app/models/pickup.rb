class Pickup < ApplicationRecord
  belongs_to :order
  validates :uncomplete, inclusion: { in: [true, false] }
  validates :airport, inclusion: { in: ["Paris CDG", "Paris Orly", "London Heathrow", "London Gatwick"], if: :complete? }
  validates :arrival, presence: { if: :complete? }
  validates :flight_number, presence: { if: :complete? }
  validate :arrival_cannot_be_in_the_past, { if: :complete? }

  AIRPORTS_FR = ["Paris CDG", "Paris Orly"]
  AIRPORTS_GB = ["London Heathrow", "London Gatwick"]

  def arrival_cannot_be_in_the_past
    errors.add(:arrival, "can't be in the past") if arrival.present? && arrival < Time.zone.now
  end

  def complete?
    !uncomplete
  end
end
