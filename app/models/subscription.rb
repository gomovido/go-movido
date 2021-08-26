class Subscription < ApplicationRecord
  belongs_to :order
  belongs_to :coupon, optional: true
  has_many :plans
  attr_accessor :terms, :terms_provider

  after_create :send_contract_agreed_email

  def active?
    state == 'active'
  end

  def send_contract_agreed_email
    UserMailer.with(user_id: order.user.id, order_id: order.id, locale: 'en').contract_agreed.deliver_later
  end

  def next_due_amount
    begin
      customer = Stripe::Customer.retrieve(order.user.stripe_id)
      Stripe::Invoice.upcoming({customer: customer.id}).amount_due.to_f / 100
    rescue
      0
    end
  end
end
