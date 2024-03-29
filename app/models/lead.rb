class Lead < ApplicationRecord
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :email, presence: true
  validates :email, uniqueness: true
end
