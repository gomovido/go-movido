class Service < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  has_many :user_services, dependent: :destroy
  has_many :houses, through: :user_services
  belongs_to :category

  def activation_price(house)
    if category.utilities?
      (category.products.find_by(country: house.country).option_types.find_by(name: 'tenants').option_values.find_by(name: house.house_detail.tenants).option_value_variant.variant.activation_price.to_d * 100).to_i
    else
      (category.products.find_by(country: house.country).activation_price.to_d * 100).to_i
    end
  end

  def subscription_price(house)
    if category.utilities?
      (category.products.find_by(country: house.country).option_types.find_by(name: 'tenants').option_values.find_by(name: house.house_detail.tenants).option_value_variant.variant.subscription_price.to_d * 100).to_i
    else
      (category.products.find_by(country: house.country).subscription_price.to_d * 100).to_i
    end
  end

  def product(country)
    category.products.find_by(country: country)
  end
end
