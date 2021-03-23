module SlackNotifier
  CLIENT = Slack::Notifier.new Rails.application.credentials.production[:slack][:token]
end
