class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home terms privacy cookies careers faq how_it_works about contact simplicity]

  def home; end

  def privacy; end

  def cookies; end

  def terms; end

  def contact; end

  def how_it_works; end

  def careers; end

  def faq; end

  def about; end

  def simplicity
    @lead = Lead.new
  end
end
