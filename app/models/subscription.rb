class Subscription < ApplicationRecord
  belongs_to :product
  belongs_to :address
  belongs_to :billing, optional: true
end
