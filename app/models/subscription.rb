class Subscription < ApplicationRecord
  belongs_to :product
  belongs_to :address
  belongs_to :billing

  validates_presence_of :start_date
end
