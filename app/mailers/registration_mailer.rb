class RegistrationMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    @locale = I18n.locale.to_s
    super
  end

  def reset_password_instructions(record, token, opts={})
    @locale = I18n.locale.to_s
    super
  end
end
