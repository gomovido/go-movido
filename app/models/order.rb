class Order < ApplicationRecord
  belongs_to :user
  belongs_to :charge, optional: true
  belongs_to :billing, optional: true
  belongs_to :shipping, optional: true
  has_one :pickup, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :state, presence: true
  validates :state, inclusion: { in: ["canceled", "pending_payment", "payment_failed", "succeeded"] }

  def total_amount
    items.includes([:product]).sum { |item| item.product.activation_price_cents }
  end

  def currency
    items.first.product.country.currency
  end

  def paid?
    state == 'succeeded'
  end

  def fr?
    items.first.product.country.code == 'fr'
  end

  def gb?
    items.first.product.country.code == 'gb'
  end
end
