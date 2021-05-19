class BookingReflex < ApplicationReflex
  delegate :current_user, to: :connection
  before_reflex :set_browser

  def create
    @user = current_user
    @booking = Booking.new(booking_params)
    @booking.user = @user
    @user.reload
    @type = current_user.flat_preference.flat_type
    fetch_flat(@type, booking_params['flat_id'], current_user.flat_preference.location)
    if @booking.save
      @booking.update(status: 'placed', locale: session[:locale])
      UserMailer.with(user: @booking.user,
                      locale: @booking.locale).booking_under_review_email.deliver_now
      @booking.slack_notification
      morph ".booking-modal-wrapper", (with_locale { render(partial: "bookings/#{device}/congratulations", locals: { flat: @flat, type: @type, booking: @booking }) })
    else
      morph ".booking-form", (with_locale { render(partial: "bookings/#{device}/form", locals: { booking: @booking, flat: @flat, user: @user }) })
      morph ".summary", (with_locale { render(partial: "bookings/#{device}/flat_summary", locals: { flat: @flat, type: @type }) })
    end
  end

  def fetch_flat(type, code, location)
    case type
    when 'student_housing'
      response = UniaccoApiService.new(code: code, location: location, country: current_user.flat_preference.country, flat_preference_id: current_user.flat_preference.id).flat
      @flat = response[:payload] if response[:status] == 200
    when 'entire_flat', 'flatshare'
      response = UniplacesApiService.new(property_code: code, flat_preference_id: current_user.flat_preference.id).flat
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
