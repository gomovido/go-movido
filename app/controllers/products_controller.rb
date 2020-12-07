class ProductsController < ApplicationController
  before_action :user_has_address?, only: [:index]

  def index
    if params[:q].present?
      @category = Category.friendly.find(params[:q][:category_id])
      params[:q]["price_gteq"]= params[:q]["price_gteq"].to_i
      params[:q]["price_lteq"]= params[:q]["price_lteq"].to_i
      @q = Product.ransack(params[:q])
    else
      @category = Category.friendly.find(params[:category_id])
      @q = Product.where(category: @category, country: current_user.country).ransack
    end
    @products = @q.result(distinct: true)
    @products = @products.where(category: @category, country: current_user.country).map{ |product| product unless product.product_features.blank? }
    if @products.blank?
      @products = Product.where(category: @category, country: current_user.country).map{ |product| product unless product.product_features.blank? }
    end
  end

  def modal
    @product = Product.friendly.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

end
