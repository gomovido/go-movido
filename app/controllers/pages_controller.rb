class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :terms, :privacy, :cookies, :careers, :faq, :how_it_works, :about, :contact ]
  before_action :user_has_address?, only: [:dashboard_index]

  def home; end

  def privacy; end

  def cookies; end

  def terms; end

  def contact; end

  def how_it_works; end

  def careers; end

  def faq; end

  def about; end

  def dashboard_index
    @categories = Category.all.order('open DESC')
  end

end
