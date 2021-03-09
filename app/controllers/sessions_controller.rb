class SessionsController < Devise::SessionsController
  # rubocop:disable Rails/LexicallyScopedActionFilter
  after_action :prepare_intercom_shutdown, only: [:destroy]
  # rubocop:enable Rails/LexicallyScopedActionFilter

  protected

  def prepare_intercom_shutdown
    IntercomRails::ShutdownHelper.intercom_shutdown_helper(cookies)
  end
end
