class Order < ApplicationRecord
  belongs_to :user
  belongs_to :charge
  belongs_to :billing
  belongs_to :shipping
  has_one :pickup, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :state, presence: true
  validates :state, inclusion: { in: ["canceled", "pending_payment", "payment_failed", "succedeed"] }

  def total_amount
    items.sum { |item| item.product.activation_price_cents }
  end

  def currency
    items.first.product.country.currency
  end
end
