class Billing < ApplicationRecord
  has_one :subscription, dependent: :destroy
  belongs_to :user
  validates_presence_of :address, :first_name, :last_name, :bic, :iban, :bank
  validates_with IbanValidator
  accepts_nested_attributes_for :subscription

  def iban_prettify
    IBANTools::IBAN.new(self.iban).prettify
  end
end
