class Country < ApplicationRecord
  has_many :addresses
  has_many :products
  has_many :users, through: :addresses
  validates_presence_of :code

end
