class HouseDetail < ApplicationRecord
  belongs_to :house
  validates :tenants, :contract_starting_date, :address, presence: true
  validates :floor, length: { maximum: 30 }
end
