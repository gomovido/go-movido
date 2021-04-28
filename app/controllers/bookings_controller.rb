class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @center = [current_user.flat_preference.coordinates[1], current_user.flat_preference.coordinates[0]]
    fetch_flat(current_user.flat_preference.flat_type, params['flat_id'], current_user.flat_preference.location)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    if @booking.save
      @booking.update(status: 'placed')
      flash[:notice] = 'Booking created!'
      redirect_to booking_path(@booking.id, flat_id: params[:booking][:flat_id])
    else
      fetch_flat(current_user.flat_preference.flat_type, params[:booking][:flat_id], current_user.flat_preference.location)
      flash[:alert] = 'An error has occured please try again or contact us.'
      render :new
    end
  end

  def show
    @booking = Booking.find_by(id: params['id'], user: current_user)
    redirect_to new_booking_path(params['flat_id']) if @booking.nil?
    fetch_flat(current_user.flat_preference.flat_type, params['flat_id'], current_user.flat_preference.location)
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
      response = UniplacesApiService.new(property_code: code, flat_preference_id: current_user.flat_preference.id).flat
      @flat = response[:flat] if response[:status] == 200
    end
    @markers = response[:markers]
    @flat = AggregatorApiService.new(flat: @flat, type: type).format_flat
  end

  def booking_params
    params.require(:booking).permit(:full_name, :email, :university, :phone, :room_type, :lease_duration, :requirements, :flat_id)
  end
end
