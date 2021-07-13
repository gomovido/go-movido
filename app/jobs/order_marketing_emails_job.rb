class OrderMarketingEmailsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    manage_orders
    manage_emails
  end

  def manage_orders
    Order.where(state: 'pending_payment').where('created_at < ?', 1.hours.ago).each do |order|
      OrderMarketing.create(order: order, title: 'orders_sequence', step: 'retarget', sent: false) if OrderMarketing.find_by(order: order).nil?
    end
  end

  def manage_emails
    OrderMarketing.where(title: 'orders_sequence', step: 'retarget').each do |marketing|
      OrderMarketingMailer.with(user: marketing.order.user).retarget.deliver_later
      marketing.update(step: 'last_call')
    end
    OrderMarketing.where(title: 'orders_sequence', step: 'last_call', sent: false).where('created_at < ?', 24.hours.ago).each do |marketing|
      OrderMarketingMailer.with(user: marketing.order.user).last_call.deliver_later
      marketing.update(sent: true)
    end
  end
end
