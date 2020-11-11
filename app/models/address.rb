class Address < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
  validates_presence_of :street, :country, :city
  validate :check_country
  after_create :set_has_active

  def set_has_active
    Address.where(active: true, user: self.user).each {|address| address.update_columns(active: false)}
    self.update_columns(active: true)
  end

  def check_country
     errors.add(:country, 'You have to select an address in the same country') unless self.country == self.user.country
  end
end
