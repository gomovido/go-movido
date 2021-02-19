class Address < ApplicationRecord
  attr_accessor :algolia_country_code
  attr_accessor :moving_country
  belongs_to :country
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
  accepts_nested_attributes_for :subscriptions
  after_create :set_has_active

  def set_has_active
    Address.where(user: self.user).each {|address| address.update_columns(active: false)}
    self.update_columns(active: true)
    Address.where(user: self.user).each do |address|
      address.destroy unless address.is_complete? || self.user.addresses.length == 1
    end
  end

  def supported_country?(algolia_country_code)
    !Country.find_by(code: algolia_country_code).nil?
  end

  def is_complete?
    !self.city.nil? && !self.city.blank? && !self.zipcode.nil? && !self.zipcode.blank? && !self.street.nil? && !self.street.blank?
  end

  def country_name_for_migration
    self.street.split(',')[-1].strip
  end
end
