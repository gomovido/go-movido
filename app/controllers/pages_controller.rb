class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end


  def dashboard_index
    @categories = Category.all
  end

end
