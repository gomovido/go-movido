class UserMailerPreview < ActionMailer::Preview

  def welcome_email
    UserMailer.with(user: User.first).welcome_email
  end

  def subscription_under_review_email
    @subscription = Subscription.first
    UserMailer.with(user: User.first).subscription_under_review_email
  end
end
