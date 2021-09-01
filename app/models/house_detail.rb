class HouseDetail < ApplicationRecord
  belongs_to :house
  validates :tenants, :contract_starting_date, :address, presence: true
  validates :floor, :numericality => { :greater_than_or_equal_to => 0 }
end
