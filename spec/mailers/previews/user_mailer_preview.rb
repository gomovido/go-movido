class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.with(user: User.first).welcome_email
  end

  def subscription_under_review_email
    UserMailer.with(user: User.first, subscription: Subscription.last, locale: 'en').subscription_under_review_email
  end

  def subscription_confirmed_email
    UserMailer.with(user: User.first, subscription: Subscription.last, locale: 'en').subscription_confirmed_email
  end

  def booking_under_review_email
    UserMailer.with(user: User.first, booking: Booking.first, locale: 'en').booking_under_review_email
  end

  def booking_confirmed_email
    UserMailer.with(user: User.first, booking: Booking.first, locale: 'en').booking_confirmed_email
  end
end