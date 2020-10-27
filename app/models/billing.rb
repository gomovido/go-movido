class Billing < ApplicationRecord
  has_many :subscriptions
  belongs_to :user
  validates_presence_of :address, :first_name, :last_name, :bic, :iban
end
