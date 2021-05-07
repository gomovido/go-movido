class Company < ApplicationRecord
  has_many :mobiles, dependent: :destroy
  has_many :wifis, dependent: :destroy
  has_many :banks, dependent: :destroy

  validates :name, :logo_url, :policy_link, presence: true
  validates :name, uniqueness: true
  validates :logo_url, format: { with: /\.(png|jpg|svg)\Z/i }
  after_update do
    mobiles.find_each(&:touch)
    wifis.find_each(&:touch)
  end
end
