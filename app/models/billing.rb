class Billing < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
  validates_presence_of :address, :bic, :iban, :bank
  validates_with IbanValidator

  def iban_prettify
    IBANTools::IBAN.new(self.iban).prettify
  end
end
