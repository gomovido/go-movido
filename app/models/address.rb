class Address < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :destroy

  validates_presence_of :country, :city, :zipcode, :street, :street_number, :floor, :phone, :mobile_phone, :internet_status
  phony_normalize :phone, default_country_code: 'FR'
  phony_normalize :mobile_phone, default_country_code: 'FR'
  validates_plausible_phone :phone, presence: true
  validates_plausible_phone :mobile_phone, presence: true
end
