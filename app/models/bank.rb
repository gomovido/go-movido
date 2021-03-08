class Bank < ApplicationRecord
  belongs_to :company
  belongs_to :category
  validates_presence_of :headline, :feature_1, :feature_2, :feature_3, :feature_4, :affiliate_link
end
