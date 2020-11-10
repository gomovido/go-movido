class Billing < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
  validates_presence_of :address, :bic, :iban, :bank
  validates_with IbanValidator
  validate :billing_address_country

  def iban_prettify
    IBANTools::IBAN.new(self.iban).prettify
  end

  def billing_address_country
     self.errors.add(:address, "needs to be in #{self.user.country}") unless !self.address.blank? && self.address.split(',')[-1].strip == self.user.country
  end
end
