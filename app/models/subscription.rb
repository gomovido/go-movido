class Subscription < ApplicationRecord
  belongs_to :product
  belongs_to :address
  has_one :billing, dependent: :destroy
  has_one :charge
  accepts_nested_attributes_for :address
  after_update :delivery_address_country


  def delivery_address_country
     self.errors.add(:delivery_address, "needs to be in #{self.address.country}") unless !self.delivery_address.blank? && self.delivery_address.split(',')[-1].strip == self.address.country
  end
end
