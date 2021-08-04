class Subscription < ApplicationRecord
  belongs_to :order
  attr_accessor :terms, :terms_provider
  after_create :send_contract_agreed_email

  def active?
    state == 'active'
  end


  def send_contract_agreed_email
    UserMailer.with(user_id: self.order.user.id, order_id: self.order.id, locale: 'en').contract_agreed.deliver_later
  end
end
