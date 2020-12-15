class Billing < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
  validates_presence_of :address, :bank, :bic, :iban, unless: :product_is_uk?
  validates_presence_of :address, :bank, :holder_name, :account_number, if: :product_is_uk?
  validates_format_of :bic, with: /\A[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$\z/i, unless: :product_is_uk?
  validates_with IbanValidator, unless: :product_is_uk?
  validate :billing_address_country
  accepts_nested_attributes_for :subscription


  def product_is_uk?
    self.subscription.product.country == 'United Kingdom'
  end

  def iban_prettify
    IBANTools::IBAN.new(self.iban).prettify
  end

  def billing_address_country
     self.errors.add(:address, I18n.t('form.failure.country', country: self.subscription.product.country)) unless !self.address.blank? && self.address.split(',')[-1].strip == self.subscription.product.country
  end


end
