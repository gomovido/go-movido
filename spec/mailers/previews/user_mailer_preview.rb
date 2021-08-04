class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.with(user_id: User.first.id).welcome_email
  end

  def password_email
    UserMailer.with(user_id: User.first.id).welcome_email
  end

  def welcome_email_without_confirmation
    UserMailer.with(user: User.first).welcome_email_without_confirmation
  end

  def contract_agreed
    UserMailer.with(user_id: User.first.id, order_id: Order.last.id, locale: 'en').contract_agreed
  end
end
