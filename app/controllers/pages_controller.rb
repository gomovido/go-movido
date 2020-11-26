class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :terms, :privacy, :cookies ]

  def home; end

  def privacy; end

  def cookies; end

  def terms; end

  def dashboard_index
    @categories = Category.all
  end

end
