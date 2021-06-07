class Company < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, :logo_url, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :logo_url, format: { with: /\.(png|jpg|svg)\Z/i }
end
