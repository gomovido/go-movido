class Booking < ApplicationRecord
  belongs_to :user
  phony_normalize :phone, default_country_code: I18n.locale.to_s.upcase
  validates_plausible_phone :phone, presence: true
  validates :full_name, :email, :university, :flat_id, presence: true
  validates :room_type, :lease_duration, presence: { if: :uniacco_flat? }

  def uniacco_flat?
    user.flat_preference.flat_type == 'student_housing'
  end

  def slack_notification
    return unless Rails.env.production?

    message = "
    🏠 Boom! New booking request made 🏠\n
    Flat ID : #{flat_id}\n
    User's email : #{email}. \n
    [Forest Admin link](https://app.forestadmin.com/go-movido-admin/#{Rails.env.capitalize}/Movido/data/Booking/index/record/Booking/#{id}/details)"
    SlackNotifier::CLIENT.ping message
  end
end
