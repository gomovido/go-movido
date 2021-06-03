class Company < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, :logo_url, :description, presence: true
  validates :name, uniqueness: true
  validates :logo_url, format: { with: /\.(png|jpg|svg)\Z/i }
end
