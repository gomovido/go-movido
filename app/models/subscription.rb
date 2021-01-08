class Subscription < ApplicationRecord
  belongs_to :product
  belongs_to :address
  has_one :billing, dependent: :destroy
  has_one :charge, dependent: :destroy
  accepts_nested_attributes_for :address
  validates :delivery_address, presence: true, on: :update
  validate :delivery_address_country, on: :update

  def product_is_wifi?
    self.product.category.name == 'wifi'
  end

  def delivery_address_country
    if self.product.company != "GifGaff" && self.delivery_address.split(',')[-1].strip != self.address.country
      self.errors.add(:delivery_address, I18n.t('addresses.edit.form.failure.wrong_country', country: self.product.country))
    elsif self.product.company == "GifGaff" && self.delivery_address.split(',').length < 2
      self.errors.add(:delivery_address, I18n.t('addresses.edit.form.failure.invalid'))
    end
  end

  def icon_state
    if self.state == 'draft'
      ''
    elsif self.state == 'succeeded'
      "fas fa-spinner"
    elsif self.state == 'activated'
      "fas fa-check-circle"
    elsif self.state == 'failed'
      "fas fa-times-circle"
    else
      "fab fa-cc-visa"
    end
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
