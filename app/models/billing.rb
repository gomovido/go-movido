class Billing < ApplicationRecord
  has_one :subscription
  validates_presence_of :address, :first_name, :last_name, :bic, :iban
end
