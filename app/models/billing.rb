class Billing < ApplicationRecord
  has_one :subscription
  accepts_nested_attributes_for :subscription
  validates_presence_of :address, :first_name, :last_name, :bic, :iban
end
