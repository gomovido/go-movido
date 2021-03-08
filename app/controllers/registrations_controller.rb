class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      p Rails.env
      UserMailer.with(user: @user, locale: I18n.locale).welcome_email.deliver_now if resource.persisted?
    end
  end
end
