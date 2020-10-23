class ProductsController < ApplicationController
  def index
    @products = Category.friendly.find(params[:category_id]).products
  end
end
