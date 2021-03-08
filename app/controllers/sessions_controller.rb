class SessionsController < Devise::SessionsController
  after_action :prepare_intercom_shutdown, only: [:destroy]

  protected

  def prepare_intercom_shutdown
    IntercomRails::ShutdownHelper.intercom_shutdown_helper(cookies)
  end
end
