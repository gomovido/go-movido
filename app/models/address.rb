class Address < ApplicationRecord
  attr_accessor :moving_country
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
  accepts_nested_attributes_for :subscriptions
  validates_presence_of :street, :city, :zipcode
  validate :fake_address
  after_create :set_has_active

  def fake_address
    self.errors.add(:street, I18n.t('addresses.edit.form.failure.invalid')) if self.city.blank? || self.zipcode.blank?
  end

  def set_has_active
    Address.where(user: self.user).each {|address| address.update_columns(active: false)}
    self.update_columns(active: true)
    Address.where(user: self.user, valid_address: false).destroy_all unless self.user.addresses.length == 1
  end

  def country
    self.street.split(',')[-1].strip
  end

end
