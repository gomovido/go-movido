class Billing < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
  validates_presence_of :address, :first_name, :last_name, :bic, :iban, :bank
  validates_with IbanValidator

  def iban_prettify
    IBANTools::IBAN.new(self.iban).prettify
  end
end
