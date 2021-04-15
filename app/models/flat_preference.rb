class FlatPreference < ApplicationRecord
  attr_accessor :coordinates, :date_range

  FACILITIES = {
    student_housing: ["kitchen", "wifi", "gym", "room_cleaning", "laundry"],
    entire_flat: ["wi_fi", "unfurnished", "accessibility", "elevator", "outdoor_area", "washing_machine"]
  }

  belongs_to :user
  validates :location, :country, :move_in, :move_out, presence: true

  def min_price
    range_min_price || 5000
  end

  def max_price
    range_max_price || 200_000
  end
end
