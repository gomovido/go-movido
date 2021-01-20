class ProductsController < ApplicationController
  before_action :user_has_address?, only: [:index]
  skip_before_action :verify_authenticity_token, only: [:create_from_forest_admin, :update_from_forest_admin]
  skip_before_action :authenticate_user!, only: [:create_from_forest_admin, :update_from_forest_admin]

  def index
    @category = Category.friendly.find(params[:category_id])
    @products = Product.where(category: @category, country: current_user.country).map{ |product| product unless product.product_features.blank? }.compact
  end

  def create_from_forest_admin
    hash = params.except(:product).except(:controller).except(:action)
    product = Product.new
    hash.each { |k, v| (product[k.split(/(?=[A-Z])/).join('_').downcase] = v) if (k != "simCardPrice") }
    product.sim_card_price = hash[:simCardPrice]
    product.save
    render :json => product
  end

  def update_from_forest_admin
    hash = params.except(:product).except(:controller).except(:action)
    product = Product.find(hash[:productId])
    hash.each { |k, v| (product[k.split(/(?=[A-Z])/).join('_').downcase] = v) if (k != "simCardPrice" && k != "productId") }
    product.sim_card_price = hash[:simCardPrice] if !hash[:simCardPrice].nil?
    product.save
    render :json => product
  end

  def modal
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

end
