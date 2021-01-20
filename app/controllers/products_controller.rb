class ProductsController < ApplicationController
  before_action :user_has_address?, only: [:index]

  def index
    @category = Category.friendly.find(params[:category_id])
    @products = Product.where(category: @category, country: current_user.country).map{ |product| product unless product.product_features.blank? }.compact
  end

  def modal
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

end
