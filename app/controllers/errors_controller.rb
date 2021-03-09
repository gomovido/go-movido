class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  def not_found
    render status: :not_found
  end

  def internal_server
    render status: :internal_server_error
  end

  def unprocessable
    render status: :unprocessable_entity
  end

  def unacceptable
    render status: :not_acceptable
  end
end
