class Country < ApplicationRecord
  validates :code, presence: true
  has_many :user_preferences, dependent: :destroy
end
