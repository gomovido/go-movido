class Address < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
  accepts_nested_attributes_for :subscriptions
  validates_presence_of :street, :city

  def set_has_active
    Address.where(user: self.user).each {|address| address.update(active: false)}
    self.update(active: true)
  end

  def country
    self.street.split(',')[-1].strip
  end
end
