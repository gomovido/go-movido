class Address < ApplicationRecord
  attr_accessor :moving_country
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
  accepts_nested_attributes_for :subscriptions
  validates_presence_of :street, :city, :zipcode
  after_create :set_has_active

  def set_has_active
    Address.where(active: true, user: self.user).each {|address| address.update_columns(active: false)}
    self.update_columns(active: true)
  end

  def country
      self.street.split(',')[-1].strip if self.street
  end

end
