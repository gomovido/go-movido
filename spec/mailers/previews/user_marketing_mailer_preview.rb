class UserMarketingMailerPreview < ActionMailer::Preview
  def retarget
    UserMarketingMailer.with(user: User.first).retarget
  end

  def second_call
    UserMarketingMailer.with(user: User.first).second_call
  end

  def last_call
    UserMarketingMailer.with(user: User.first).last_call
  end

end
