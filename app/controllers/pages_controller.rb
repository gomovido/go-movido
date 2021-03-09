class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home terms privacy cookies careers faq how_it_works about contact]

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
