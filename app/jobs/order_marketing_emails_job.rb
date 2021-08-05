class OrderMarketingEmailsJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    manage_orders
    retarget
    last_call
    feedback
  end

  def manage_orders
    order_unpaid
    order_paid
  end

  def order_unpaid
    Order.where(state: 'pending_payment').where('created_at < ?', 1.hour.ago).each do |order|
      OrderMarketing.create(order: order, title: 'orders_sequence', step: 'retarget', sent: false) if OrderMarketing.find_by(order: order).nil?
    end
  end

  def order_paid
    Order.where(state: 'succeeded').where('created_at < ?', 1.week.ago).each do |order|
      OrderMarketing.create(order: order, title: 'orders_sequence', step: 'feedback', sent: false) if OrderMarketing.find_by(order: order).nil?
    end
  end

  def retarget
    OrderMarketing.where(title: 'orders_sequence', step: 'retarget').each do |marketing|
      marketing.update(step: 'last_call', bounced: false) if send_email_retarget(marketing)
    end
  end

  def last_call
    OrderMarketing.where(title: 'orders_sequence', step: 'last_call', sent: false).where('created_at < ?', 24.hours.ago).each do |marketing|
      OrderMarketingMailer.with(user: marketing.order.user, order: marketing.order).last_call.deliver_later
      marketing.update(sent: true)
    end
  end

  def feedback
    OrderMarketing.where(title: 'orders_sequence', step: 'feedback', sent: false).each do |marketing|
      OrderMarketingMailer.with(user: marketing.order.user).feedback.deliver_later
      marketing.update(sent: true)
    end
  end

  def send_email_retarget(marketing)
    OrderMarketingMailer.with(user: marketing.order.user, order: marketing.order).retarget.deliver_later
    return true
  rescue StandardError
    marketing.update(bounced: true)
    return false
  end
end
