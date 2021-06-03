class Pickup < ApplicationRecord
  belongs_to :order
  validates :arrival, :airport, :state, presence: true
end
