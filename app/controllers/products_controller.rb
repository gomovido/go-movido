class ProductsController < ApplicationController
  def index
    @products = Category.friendly.find(params[:category_id]).products
    @category_name = @products.first.category.name
  end
end
