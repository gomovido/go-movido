class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :privacy, :cookies ]

  def home; end

  def privacy; end

  def cookies; end

  def dashboard_index
    @categories = Category.all
  end

end
