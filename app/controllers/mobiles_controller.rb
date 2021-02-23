class MobilesController < ApplicationController
  def index
    @products = Mobile.where(active: true).map{ |product| product unless product.product_features.blank? }.compact
    @address ||= Address.new
  end

  def modal
    @product = Mobile.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

end
