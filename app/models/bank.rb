class Bank < ApplicationRecord
  belongs_to :company, optional: true
  validates_format_of :affiliate_link, with: URI::regexp(%w[http https])
  validates_presence_of :headline, :feature_1, :feature_2, :feature_3, :feature_4
end
