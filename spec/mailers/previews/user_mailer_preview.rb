class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.with(user_id: User.last.id).welcome_email
  end

  def password_email
    UserMailer.with(user_id: User.last.id).welcome_email
  end

  def order_confirmed
    UserMailer.with(user_id: User.last.id, order_id: Order.last.id).order_confirmed
  end

  def contract_agreed
    UserMailer.with(user_id: User.last.id, order_id: Order.last.id, locale: 'en').contract_agreed
  end
end
