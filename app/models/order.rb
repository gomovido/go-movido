class Order < ApplicationRecord
  belongs_to :user
  belongs_to :charge, optional: true
  belongs_to :billing, optional: true
  belongs_to :shipping, optional: true
  has_one :pickup, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :state, presence: true
  validates :state, inclusion: { in: ["canceled", "pending_payment", "succeeded"] }

  def total_amount
    items.includes([:product]).sum { |item| item.product.activation_price_cents }
  end

  def total_amount_display
    total_amount.to_f / 100
  end

  def ready_to_checkout?
    user.house.pickup? ? shipping && pickup : shipping
  end

  def slack_notification
    return unless Rails.env.production?

    slack_notification = "
    💸 Boom! New starter pack purchased 💸\n
    User's email : #{user.email}. \n
    Arrival country : #{user.house.country.title} \n
    Price : #{currency_symbol}#{total_amount_display} \n
    Items : #{items.map { |item| item.product.category.name.titlecase }.join(', ')} \n
    [Forest Admin link](https://app.forestadmin.com/go-movido/#{Rails.env.capitalize}/Movido/data/Order/index/record/Order/#{id}/details)"
    SlackNotifier::CLIENT.ping slack_notification
  end

  def currency
    items.first.product.country.currency
  end

  def currency_symbol
    fr? ? '€' : '£'
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
