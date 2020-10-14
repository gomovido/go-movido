class Billing < ApplicationRecord
  has_one :subscription
end
