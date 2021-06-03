class Cart < ApplicationRecord
  belongs_to :user_preference
  has_many :items, dependent: :destroy
end
