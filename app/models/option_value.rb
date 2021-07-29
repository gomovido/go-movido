class OptionValue < ApplicationRecord
  belongs_to :option_type
  has_one :option_value_variant
end
