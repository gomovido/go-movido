class BookingReflex < ApplicationReflex
  delegate :view_context, to: :controller
  delegate :current_user, to: :connection
  before_reflex :set_browser


  def create
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.user = @user
    @user.reload
    fetch_flat(current_user.flat_preference.flat_type, booking_params['flat_id'], current_user.flat_preference.location)
    if @booking.save
      morph ".booking-form", render(partial: "bookings/#{device}/congratulations")
    else
      morph ".booking-form", render(partial: "bookings/#{device}/form", locals: { booking: @booking, flat: @flat, user: @user })
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

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end

  def booking_params
    params.require(:booking).permit(:full_name, :email, :university, :phone, :room_type, :lease_duration, :requirements, :flat_id)
  end
end
