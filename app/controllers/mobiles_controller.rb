class MobilesController < ApplicationController
  def index
    @products = Mobile.where(country: current_user.active_address.country, active: true).map do |product|
      product if product.product_features.present?
    end.compact
  end

  def modal
    @product = Mobile.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end
end
