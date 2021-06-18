class UserPreference < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_many :carts, dependent: :destroy
  has_many :user_services, dependent: :destroy
  has_many :services, through: :user_services

  validates :arrival, :stay_duration, presence: true
  validate :arrival_cannot_be_in_the_past
  validate :country_id_present
  attr_accessor :terms, :marketing


  def country_id_present
    errors.add(:country_id, "can't be blank") if country_id.blank?
  end

  def arrival_cannot_be_in_the_past
    errors.add(:arrival, "can't be in the past") if arrival.present? && arrival < Time.zone.now
  end

  def pickup?
    user_services.find_by(user_preference: self, service: Service.find_by(name: 'pickup')).present?
  end
end
