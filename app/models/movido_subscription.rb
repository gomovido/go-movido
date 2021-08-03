class MovidoSubscription < ApplicationRecord
  has_one :subscription, dependent: :destroy
end
