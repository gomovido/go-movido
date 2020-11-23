class BillingsController < ApplicationController

  def new
    @subscription = Subscription.find(params[:id])
  end

  def new_uk
  end

  def new_europe
  end
end
