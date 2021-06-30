class House < ApplicationRecord
  belongs_to :user
  belongs_to :country
  has_many :carts, dependent: :destroy
  has_many :user_services, dependent: :destroy
  has_many :services, through: :user_services

  validate :country_id_present
  attr_accessor :terms, :marketing

  def country_id_present
    errors.add(:country_id, "can't be blank") if country_id.blank?
  end

  def city
    country.code == 'fr' ? 'Paris' : 'London'
  end

  def pickup?
    user_services.find_by(house: self, service: Service.find_by(name: 'pickup')).present?
  end
end
