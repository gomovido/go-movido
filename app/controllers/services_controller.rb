class ServicesController < ApplicationController
  skip_before_action :authenticate_user!

  def wifi; end

  def bank; end

  def real_estate; end

  def mobile; end
end
