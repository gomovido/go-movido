class Address < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :destroy

  validates_presence_of :street, :country
  phony_normalize :mobile_phone, default_country_code: 'FR'
  #validates_plausible_phone :mobile_phone, presence: true, unless: -> { self.phoned }, on: :update
  validate :check_country
  after_create :set_has_active
  #after_update :clean_number, if: -> { self.phoned }

  def set_has_active
    address = Address.find_by(active: true, user: self.user)
    address.update(active: false) if address
    self.update_columns(active: true)
  end

  def check_country
    self.country == self.user.country
  end
end
