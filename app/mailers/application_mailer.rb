class ApplicationMailer < ActionMailer::Base
  default from: 'info@go-movido.com'
  layout 'mailer'
  helper ApplicationHelper

end
