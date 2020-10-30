class Billing < ApplicationRecord
  has_one :subscription, dependent: :destroy
  belongs_to :user
  validates_presence_of :address, :first_name, :last_name, :bic, :iban
  accepts_nested_attributes_for :subscription
end
