class Booking < ApplicationRecord
  belongs_to :user
  validates :full_name, :email, :university, :phone, presence: true
end
