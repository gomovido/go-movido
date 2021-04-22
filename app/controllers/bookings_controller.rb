class BookingsController < ApplicationController

  def create
  end

  def modal
    @booking = Booking.new
    @user = current_user
    fetch_flat(current_user.flat_preference.flat_type, params[:flat_id], current_user.flat_preference.location)
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def fetch_flat(type, code, location)
    case type
    when 'student_housing'
      response = UniaccoApiService.new(code: code, location: location, country: current_user.flat_preference.country, flat_preference_id: current_user.flat_preference.id).flat
      @flat = response[:payload] if response[:status] == 200
    when 'entire_flat'
      response = UniplacesApiService.new(property_code: code).flat
      @flat = response[:flat] if response[:status] == 200
    end
    @flat = AggregatorApiService.new(flat: @flat, type: type).format_flat
  end
end
