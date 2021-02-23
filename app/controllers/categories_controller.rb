class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order('open DESC')
  end
end
