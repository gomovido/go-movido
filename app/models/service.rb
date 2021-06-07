class Service < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :user_services, dependent: :destroy
  has_many :user_preferences, through: :user_services
  belongs_to :category
end
