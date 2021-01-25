class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super do |resource|
      UserMailer.with(user: @user, locale: I18n.locale).welcome_email.deliver_now if resource.persisted?
    end
  end

end
