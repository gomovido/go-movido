class CategoriesController < ApplicationController
  before_action :user_has_address?, only: [:index]
  def index
    @categories = Category.all.order('open DESC')
  end
end
