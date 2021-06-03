class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :charge
  belongs_to :order
end
