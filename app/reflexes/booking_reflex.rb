class BookingReflex < ApplicationReflex
  delegate :view_context, to: :controller
  delegate :current_user, to: :connection
  before_reflex :set_browser


  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    morph ".booking-form", render(partial: "bookings/#{device}/congratulations") if @booking.save!
  end

  private

  def set_browser
    @browser = Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def device
    @browser.device.mobile? ? 'mobile' : 'desktop'
  end

  def booking_params
    params.require(:booking).permit(:full_name, :email, :university, :phone, :room_type, :lease_duration, :requirements)
  end
end
