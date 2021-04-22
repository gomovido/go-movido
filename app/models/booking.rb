class Booking < ApplicationRecord
  belongs_to :user
  phony_normalize :phone, default_country_code: I18n.locale.to_s.upcase
  validates_plausible_phone :phone, presence: true
  validates :full_name, :email, :university, :flat_id, presence: true
  validates :room_type, :lease_duration, presence: { if: :uniacco_flat? }


  def uniacco_flat?
    self.user.flat_preference.flat_type == 'student_housing'
  end

end
