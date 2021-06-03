class Order < ApplicationRecord
  belongs_to :user
  belongs_to :charge
  belongs_to :billing
  belongs_to :shipping
  has_one :pickup
  validates :state, presence: true
end
