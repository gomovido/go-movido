class UserPreference < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_one :cart, dependent: :destroy
  has_many :user_services, dependent: :destroy
  has_many :services, through: :user_services

  validates :arrival, :stay_duration, presence: true
  validate :arrival_cannot_be_in_the_past

  def arrival_cannot_be_in_the_past
    errors.add(:arrival, "can't be in the past") if arrival.present? && arrival < Time.zone.now
  end
end
