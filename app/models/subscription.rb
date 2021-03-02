class Subscription < ApplicationRecord
  attr_accessor :algolia_country_code
  belongs_to :address
  belongs_to :product, polymorphic: true
  has_one :billing, dependent: :destroy
  has_one :charge, dependent: :destroy
  accepts_nested_attributes_for :address

  validates :delivery_address, presence: true, on: :update
  validate :delivery_address_country, on: :update, if: :delivery_address?
  validates_plausible_phone :contact_phone, presence: true, on: :update, if: :product_is_wifi?
  validate :contact_phone_country, on: :update, if: :product_is_wifi?

  def product_is_wifi?
    self.product_type == 'Wifi'
  end

  def product_is_mobile?
    self.product_type == 'Mobile'
  end

  def product_is_uk?
    self.product.country.code == 'gb'
  end

  def path_to_first_step
    if self.product_is_wifi?
      Rails.application.routes.url_helpers.edit_subscription_address_path(self, self.address, locale: I18n.locale)
    elsif self.product_is_mobile?
      Rails.application.routes.url_helpers.new_subscription_billing_path(self, locale: I18n.locale)
    end
  end

  def delivery_address_country
    if self.product.company.name.downcase != "giffgaff" && self.algolia_country_code != self.address.country.code
      self.errors.add(:delivery_address, I18n.t('addresses.edit.form.failure.wrong_country', country:  I18n.t("country.#{self.product.country.code}")))
    elsif self.product.company.name.downcase == "giffgaff" && self.delivery_address.split(',').length < 2
      self.errors.add(:delivery_address, I18n.t('addresses.edit.form.failure.invalid'))
    end
  end

  def icon_state
    if self.state == 'draft'
      'far fa-clipboard-list'
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

  def contact_phone_country
    country_code_number = IsoCountryCodes.find(self.product.country.code).calling
    if !self.contact_phone.start_with?(country_code_number)
      self.errors.add(:contact_phone, I18n.t('addresses.edit.form.failure.wrong_country', country:  I18n.t("country.#{self.product.country.code}")))
    end
  end

  def current_step(controller_name)
    if self.product_is_wifi?
      if controller_name == 'addresses'
        2
      elsif controller_name == 'billings'
        3
      else
        4
      end
    elsif self.product_is_mobile? && self.product.has_payment?
      if controller_name == 'billings'
        2
      elsif controller_name == 'subscriptions'
        3
      else
        4
      end
    elsif self.product_is_mobile? && !self.product.has_payment?
      controller_name == 'billings' ? 2 : 3
    end
  end
end
