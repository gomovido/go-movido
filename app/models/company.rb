class Company < ApplicationRecord

  has_many :mobiles, dependent: :destroy
  has_many :wifis, dependent: :destroy
  has_many :banks, dependent: :destroy

  validates_presence_of :name, :logo_url
  validates_uniqueness_of :name
  validates :logo_url, format: {with: /\.(png|jpg|svg)\Z/i}
  validates :cancel_link, format: { with: URI.regexp }, if: :cancel_link?

end
