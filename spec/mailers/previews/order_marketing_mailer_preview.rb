class OrderMarketingMailerPreview < ActionMailer::Preview
  def retarget
    OrderMarketingMailer.with(user: Order.last.user).retarget
  end

  def last_call
    OrderMarketingMailer.with(user: Order.last.user).last_call
  end

  def feedback
    OrderMarketingMailer.with(user: Order.last.user).feedback
  end

end
