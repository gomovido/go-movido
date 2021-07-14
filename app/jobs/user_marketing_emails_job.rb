class UserMarketingEmailsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    manage_users
    retarget
    second_call
    last_call
  end

  def manage_users
    User.where.not(id: Order.all.pluck(:user_id)).where('created_at < ?', 48.hours.ago).each do |user|
     UserMarketing.create(user: user, title: 'users_sequence', step: 'retarget') if UserMarketing.find_by(user: user).nil?
    end
  end

  def retarget
    UserMarketing.where(title: 'users_sequence', step: 'retarget').each do |marketing|
      UserMarketingMailer.with(user: marketing.user).retarget.deliver_later
      marketing.update(step: 'second_call')
    end
  end

  def second_call
    UserMarketing.where(title: 'users_sequence', step: 'second_call').where('created_at < ?',72.hours.ago).each do |marketing|
      UserMarketingMailer.with(user: marketing.user).second_call.deliver_later
      marketing.update(step: 'last_call')
    end
  end

  def last_call
    UserMarketing.where(title: 'users_sequence', step: 'last_call', sent: false).where('created_at < ?', 72.hours.ago).each do |marketing|
      UserMarketingMailer.with(user: marketing.user).second_call.deliver_later
      marketing.update(sent: true)
    end
  end

end
