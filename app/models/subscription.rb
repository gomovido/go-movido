class Subscription < ApplicationRecord
  belongs_to :product
  belongs_to :address
  has_one :billing, dependent: :destroy
  has_one :charge
  accepts_nested_attributes_for :address
  after_update :delivery_address_country
  validates :delivery_address, presence: true, if: :product_is_wifi?, on: :update
  validate :delivery_address_country, if: :product_is_wifi?, on: :update

  def product_is_wifi?
    self.product.category.name == 'wifi'
  end

  def delivery_address_country
     self.errors.add(:delivery_address, "needs to be in #{self.address.country}") if self.delivery_address.nil? or (!self.delivery_address.blank? && self.delivery_address.split(',')[-1].strip != self.address.country)
  end

  def current_step(controller_name)
    if self.product.is_wifi?
      if controller_name == 'addresses'
        2
      elsif controller_name == 'billings'
        3
      else
        4
      end
    elsif self.product.is_mobile? && self.product.has_payment?
      if controller_name == 'billings'
        2
      elsif controller_name == 'subscriptions'
        3
      else
        4
      end
    elsif self.product.is_mobile? && !self.product.has_payment?
      controller_name == 'billings' ? 2 : 3
    end
  end
end
