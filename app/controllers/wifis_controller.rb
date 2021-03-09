class WifisController < ApplicationController
  def index
    @products = Wifi.where(country: current_user.active_address.country, active: true).map do |product|
      product if product.product_features.present?
    end.compact
    # rubocop:disable Naming/MemoizedInstanceVariableName
    @address ||= Address.new
    # rubocop:enable Naming/MemoizedInstanceVariableName
  end

  def modal
    @product = Wifi.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end
end
