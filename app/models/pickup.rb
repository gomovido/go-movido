class Pickup < ApplicationRecord
  belongs_to :order
  validates :arrival, :airport, :state, presence: true
  validates :state, inclusion: { in: ["confirmed", "waiting_for_details"] }
  validates :airport, inclusion: { in: ["Paris CDG", "Paris Orly", "London Heathrow", "London Gatwick"] }
  validate :arrival_cannot_be_in_the_past

  def arrival_cannot_be_in_the_past
    errors.add(:arrival, "can't be in the past") if arrival.present? && arrival < Time.zone.now
  end
end
