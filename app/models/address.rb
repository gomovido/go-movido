class Address < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
end
