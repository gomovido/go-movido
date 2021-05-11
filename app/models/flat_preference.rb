class FlatPreference < ApplicationRecord
  attr_accessor :date_range

  TYPES = ["student_housing", "entire_flat", "flatshare" , "upscale_housing" ]
  FACILITIES = {
    student_housing: ["kitchen", "wifi", "gym", "room_cleaning", "laundry"],
    entire_flat: ["wi_fi", "unfurnished", "accessibility", "elevator", "outdoor_area", "washing_machine"],
    flatshare: ["wi_fi", "unfurnished", "accessibility", "elevator", "outdoor_area", "washing_machine"]
  }

  belongs_to :user
  validates :location, :country, :move_in, :move_out, :coordinates, presence: true

  def min_price
    range_min_price || 5000
  end

  def max_price
    range_max_price || 200_000
  end
end
