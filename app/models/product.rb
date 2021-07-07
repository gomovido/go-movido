class Product < ApplicationRecord
  belongs_to :company
  belongs_to :category
  belongs_to :country
  has_many :product_details, dependent: :destroy
  has_many :items, dependent: :destroy
  after_create :set_sku

  validates :name, :activation_price, :subscription_price, :image_url, :description, presence: true

  def activation_price_cents
    (activation_price * 10 * 10).to_i
  end

  def set_sku
    update(sku: "#{country.code}_#{company.name.tr(' ', '_')}_#{category.sku}_#{name.tr(' ', '_')}".downcase)
  end
end
