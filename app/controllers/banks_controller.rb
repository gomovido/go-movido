class BanksController < ApplicationController

  def index
    @banks = Bank.all
  end

  def modal
    @bank = Bank.find(params[:id])
    respond_to do |format|
      format.html { render layout: false }
    end
  end

end
