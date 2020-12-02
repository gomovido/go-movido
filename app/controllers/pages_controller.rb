class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :terms, :privacy, :cookies ]

  def home; end

  def privacy; end

  def cookies; end

  def terms; end

  def dashboard_index
    redirect_to(new_user_address_path(current_user.id)) if current_user.active_address.nil?
    @categories = Category.all
  end

end
