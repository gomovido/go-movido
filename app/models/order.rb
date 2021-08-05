class Order < ApplicationRecord
  belongs_to :user
  belongs_to :charge, optional: true
  belongs_to :billing, optional: true
  belongs_to :shipping, optional: true
  has_one :pickup, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :products, through: :items
  has_one :order_marketing, dependent: :destroy
  attr_accessor :terms, :marketing
  validates :state, presence: true
  validates :state, inclusion: { in: ["canceled", "pending_payment", "succeeded"] }

  def total_activation_amount
    items.includes([:product]).sum { |item| item.product.category.utilities? ? item.product.variant_activation_price(user.house) : item.product.activation_price_cents }
  end

  def total_subscription_amount
    items.includes([:product]).sum { |item| item.product.category.utilities? ? item.product.variant_subscription_price(user.house) : item.product.subscription_price_cents }
  end

  def total_amount_display
    total_activation_amount.to_f / 100
  end

  def total_subscription_amount_display
    total_subscription_amount.to_f / 100
  end

  def ready_to_checkout?
    if pack == 'settle_in'
      true
    else
      user.house.pickup? ? shipping && pickup : shipping
    end
  end

  def currency
    items.first.product.country.currency
  end

  def currency_symbol
    fr? ? '€' : '£'
  end

  def pack
    products&.first&.category&.pack&.name
  end

  def cart
    items&.first&.cart
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
