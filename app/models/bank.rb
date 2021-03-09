class Bank < ApplicationRecord
  belongs_to :company
  belongs_to :category
  validates :headline, :feature_1, :feature_2, :feature_3, :feature_4, :affiliate_link, presence: true
end
