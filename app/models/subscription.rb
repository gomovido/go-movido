class Subscription < ApplicationRecord
  belongs_to :product
  belongs_to :address
  has_one :billing, dependent: :destroy
  accepts_nested_attributes_for :billing
end
