class Service < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :user_services, dependent: :destroy
  has_many :user_preferences, through: :user_services
  belongs_to :category


  def price(country)
    (category.products.find_by(country: country).activation_price.to_d * 100).to_i
  end
end
