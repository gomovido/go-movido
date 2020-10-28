class Address < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :destroy

  validates_presence_of :street
  #phony_normalize :phone, default_country_code: 'FR'
  #phony_normalize :mobile_phone, default_country_code: 'FR'
  #validates_plausible_phone :phone, presence: true
  #validates_plausible_phone :mobile_phone, presence: tru
  after_create :set_has_active



  def set_has_active
    address = Address.find_by(active: true, user: self.user)
    address.update(active: false) if address
    self.update(active: true)
  end
end
