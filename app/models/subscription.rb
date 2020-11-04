class Subscription < ApplicationRecord
  belongs_to :product
  belongs_to :address
  has_one :billing
  accepts_nested_attributes_for :billing
end
