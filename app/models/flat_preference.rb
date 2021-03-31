class FlatPreference < ApplicationRecord
  belongs_to :user

  def active?
    range_min_price || range_max_price || dishwasher || microwave
  end
end
