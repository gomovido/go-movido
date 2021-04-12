class FlatPreference < ApplicationRecord
  belongs_to :user

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

  def move_out
    end_date || start_date + 14.days
  end
end
