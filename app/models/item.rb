class Item < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :charge, optional: true
  belongs_to :order, optional: true
end
