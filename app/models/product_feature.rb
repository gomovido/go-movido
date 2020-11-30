class ProductFeature < ApplicationRecord
  belongs_to :product
  validates_presence_of :name, :description

end
