class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :privacy ]

  def home; end

  def privacy; end


  def dashboard_index
    @categories = Category.all
  end

end
