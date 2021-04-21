class BookingsController < ApplicationController

  def create
  end

  def modal
    @booking = Booking.new
    respond_to do |format|
      format.html { render layout: false }
    end
  end
end
