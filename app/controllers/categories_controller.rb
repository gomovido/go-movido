class CategoriesController < ApplicationController
  before_action :user_has_address?, only: [:index]
  def index
    @categories = Category.all.order('sort_id ASC')
  end
end
