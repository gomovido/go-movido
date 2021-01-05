class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :terms, :privacy, :cookies, :careers ]
  before_action :user_has_address?, only: [:dashboard_index]
  def home; end

  def privacy; end

  def cookies; end

  def terms; end

  def careers; end

  def dashboard_index
    @categories = Category.all
  end

end
