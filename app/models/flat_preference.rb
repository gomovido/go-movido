class FlatPreference < ApplicationRecord
  attr_accessor :coordinates

  belongs_to :user
  validates :location, :country, presence: true

  after_initialize if: :new_record? do
    self.move_out = Time.zone.now + 30.days
    self.move_in = Time.zone.now
  end

  def active?
    range_min_price || range_max_price || dishwasher || microwave
  end

  def min_price
    range_min_price || 50
  end

  def max_price
    range_max_price || 2000
  end

  def facilities
    attributes.filter_map { |k, v| k if v == true }
  end
end
