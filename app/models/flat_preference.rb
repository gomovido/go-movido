class FlatPreference < ApplicationRecord
  belongs_to :user

  def active?
    range_min_price || range_max_price || dishwasher || microwave
  end

  def min_price
    range_min_price || start_min_price
  end

  def max_price
    range_max_price || start_max_price
  end

  def facilities
    attributes.filter_map { |k, v| k if v == true }
  end
end
