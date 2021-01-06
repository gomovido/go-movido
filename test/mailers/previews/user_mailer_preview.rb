class UserMailerPreview < ActionMailer::Preview

  def welcome_email
    UserMailer.with(user: User.first).welcome_email
  end

  def subscription_under_review_email
    @subscription = Subscription.first
    UserMailer.with(user: User.first).subscription_under_review_email
  end

  def booking_under_review_email
    UserMailer.with(user: User.first).booking_under_review_email
  end

  def subscription_confirmed_email
    UserMailer.with(user: User.first, subscription: Subscription.first).subscription_confirmed_email
  end

  def booking_confirmed_email
    UserMailer.with(user: User.first).booking_confirmed_email
  end

end
