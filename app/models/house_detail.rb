class HouseDetail < ApplicationRecord
  belongs_to :house
  validates :tenants, :contract_starting_date, :address, presence: true
end
